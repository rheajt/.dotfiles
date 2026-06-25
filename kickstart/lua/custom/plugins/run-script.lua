-- Open tmux sidebar and run the npm scripts
local function get_npm_scripts()
  local file = io.open('package.json', 'r')
  if file then
    local content = file:read '*a'
    file:close()
    local packageData = vim.json.decode(content)
    if packageData.scripts then
      local scripts = {}
      for key, value in pairs(packageData.scripts) do
        -- add key, value to the scripts table
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

-- Open custom picker
local function run_npm_script()
  local scripts = get_npm_scripts()
  -- if scripts is a string then print it and exit
  if type(scripts) == 'string' then
    print(scripts)
    return
  end

  local runner = vim.fn.filereadable '.bun-version' == 1 and 'bun' or 'npm'
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

      os.execute('tmux-split-right ' .. vim.fn.shellescape(item.run_command))
    end,
  }
end

vim.keymap.set('n', '<leader>sns', function() run_npm_script() end, { silent = true, desc = '[S]plit [N]ew [S]idebar' })
