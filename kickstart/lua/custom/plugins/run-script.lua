-- Open a right-side split and run the npm scripts
local function get_npm_scripts()
    local file = io.open('package.json', 'r')
    if file then
        local content = file:read('*a')
        file:close()
        local packageData = vim.json.decode(content)
        if packageData.scripts then
            local scripts = {}
            for key, value in pairs(packageData.scripts) do
                scripts[key] = value
            end
            return scripts
        else
            return 'No scripts found in package.json'
        end
    else
        return 'package.json file not found'
    end
end

_G.CloseRunScriptTerm = function()
    local win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_is_valid(win) then
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_buf_delete(buf, { force = true })
    end
end

-- Open custom picker
local function run_npm_script()
    local scripts = get_npm_scripts()
    if type(scripts) == 'string' then
        print(scripts)
        return
    end

    local runner = vim.fn.filereadable('.bun-version') == 1 and 'bun' or 'npm'
    local entries = {}

    for name, command in pairs(scripts) do
        table.insert(entries, { name = name, command = command })
    end

    table.sort(entries, function(a, b) return a.name < b.name end)

    local items = vim.tbl_map(function(entry)
        local command = runner .. ' run ' .. entry.name
        return {
            text = command .. ' ' .. entry.command,
            name = entry.name,
            command = entry.command,
            run_command = command,
        }
    end, entries)

    Snacks.picker {
        title = 'Package Scripts',
        items = items,
        format = function(item)
            return {
                { Snacks.picker.util.align(item.run_command, 23, { truncate = true }), 'SnacksPickerCmd' },
                { ' : ', 'SnacksPickerDelim' },
                { item.command, 'SnacksPickerDesc' },
            }
        end,
        preview = 'none',
        confirm = function(picker, item)
            picker:close()

            if not item then return end

            local term_win = nil
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.b[buf].is_run_script_term then
                    term_win = win
                    break
                end
            end

            if not term_win or not vim.api.nvim_win_is_valid(term_win) then
                vim.cmd('botright vsplit')
                term_win = vim.api.nvim_get_current_win()
            else
                vim.api.nvim_set_current_win(term_win)
            end

            local buf = vim.api.nvim_create_buf(false, true)
            vim.b[buf].is_run_script_term = true
            vim.api.nvim_win_set_buf(term_win, buf)

            vim.fn.termopen(item.run_command, { cwd = vim.fn.getcwd() })
            vim.wo[term_win].winbar = "%#WarningMsg#%=%@v:lua.CloseRunScriptTerm@ [X] Close %X"

            vim.keymap.set('n', 'q', '<cmd>bwipeout!<cr>', { buffer = buf, silent = true, desc = 'Close Terminal' })
            vim.cmd('startinsert')
        end,
    }
end

vim.keymap.set('n', '<leader>sns', function() run_npm_script() end, { silent = true, desc = '[S]plit [N]ew [S]cript' })
