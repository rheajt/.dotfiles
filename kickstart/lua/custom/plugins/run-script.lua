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

  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local entry_display = require 'telescope.pickers.entry_display'

  local displayer = entry_display.create {
    separator = ' : ',
    items = {
      { width = 23 },
      { remaining = true },
    },
  }

  pickers
    .new({}, {
      prompt_title = 'Package Scripts',
      finder = finders.new_table {
        results = entries,
        entry_maker = function(entry)
          return {
            value = entry.name,
            ordinal = entry.name .. ' ' .. entry.command,
            display = function()
              return displayer {
                runner .. ' run ' .. entry.name,
                entry.command,
              }
            end,
          }
        end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if not selection then return end

          os.execute('tmux-split-right ' .. vim.fn.shellescape(runner .. ' run ' .. selection.value))
        end)

        return true
      end,
    })
    :find()
end

vim.keymap.set('n', '<leader>sns', function() run_npm_script() end, { silent = true, desc = '[S]plit [N]ew [S]idebar' })
