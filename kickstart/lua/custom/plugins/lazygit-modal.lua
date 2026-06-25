local function get_project_dir()
    local current_file = vim.api.nvim_buf_get_name(0)
    local search_path = current_file ~= '' and current_file or vim.uv.cwd()

    return vim.fs.root(search_path, { '.git' }) or vim.uv.cwd()
end

local function open_lazygit_modal()
    if vim.fn.executable 'lazygit' ~= 1 then
        vim.notify('lazygit is not installed or not on PATH', vim.log.levels.ERROR)
        return
    end

    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.85)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buffer = vim.api.nvim_create_buf(false, true)
    vim.bo[buffer].bufhidden = 'wipe'

    local window = vim.api.nvim_open_win(buffer, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
        title = ' lazygit ',
        title_pos = 'center',
    })

    vim.wo[window].winhl = 'Normal:NormalFloat,FloatBorder:FloatBorder'

    vim.fn.termopen({ 'lazygit' }, {
        cwd = get_project_dir(),
        on_exit = function()
            vim.schedule(function()
                if vim.api.nvim_win_is_valid(window) then
                    vim.api.nvim_win_close(window, true)
                end
            end)
        end,
    })

    vim.cmd.startinsert()
end

vim.keymap.set(
    'n',
    '<leader>lg',
    open_lazygit_modal,
    { silent = true, desc = 'Open [L]azy[G]it' }
)
