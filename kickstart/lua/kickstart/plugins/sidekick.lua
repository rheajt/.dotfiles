vim.pack.add {
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/folke/sidekick.nvim',
}

vim.schedule(function()
  require('copilot').setup {
    filetypes = {
      norg = false,
      ['snacks.picker'] = false,
    },
    suggestion = { enabled = true, auto_trigger = true, keymap = {
      accept = '<Right>',
      next = '<Up>',
      prev = '<Down>',
    } },
  }

  require('sidekick').setup {
    cli = {
      mux = {
        backend = 'tmux',
        enabled = true,
      },
    },
  }
end, 0)

vim.keymap.set('n', '<C-y>', function()
  if not require('sidekick').nes_jump_or_apply() then return '<Tab>' end
end, { desc = 'Goto/Apply Next Edit Suggestion' })

vim.keymap.set('n', '<c-.>', function() require('sidekick.cli').toggle() end, { desc = 'Sidekick Toggle' })
vim.keymap.set('n', '<leader>aa', function() require('sidekick.cli').toggle() end, { desc = 'Sidekick Toggle CLI' })
vim.keymap.set('n', '<leader>as', function() require('sidekick.cli').select() end, { desc = 'Select CLI' })
vim.keymap.set('n', '<leader>ad', function() require('sidekick.cli').close() end, { desc = 'Detach a CLI Session' })
vim.keymap.set({ 'x', 'n' }, '<leader>at', function() require('sidekick.cli').send { msg = '{this}' } end, { desc = 'Send This' })
vim.keymap.set('n', '<leader>af', function() require('sidekick.cli').send { msg = '{file}' } end, { desc = 'Send File' })
vim.keymap.set('x', '<leader>av', function() require('sidekick.cli').send { msg = '{selection}' } end, { desc = 'Send Visual Selection' })

vim.keymap.set(
  { 'x', 'n' },
  '<leader>ap',
  function()
    require('sidekick.cli').prompt {
      prompts = { hello = 'world' },
    }
  end,
  { desc = 'Sidekick Select Prompt' }
)

vim.keymap.set('n', '<leader>ac', function() require('sidekick.cli').toggle { name = 'opencode', focus = true } end, { desc = 'Sidekick Toggle Opencode' })

-- Copilot insert mode keymaps (these auto-load copilot on first use)
vim.keymap.set('i', '<right>', function() require('copilot.suggestion').accept() end, { desc = 'Accept Copilot suggestion' })
vim.keymap.set('i', '<up>', function() require('copilot.suggestion').next() end, { desc = 'Next Copilot Suggestion' })
vim.keymap.set('i', '<down>', function() require('copilot.suggestion').prev() end, { desc = 'Prev Copilot Suggestion' })
vim.keymap.set('n', '<leader>co', function()
  local issues = vim.fn.glob('issues/*.md', false, true)
  local commits = vim.fn.systemlist 'git log -n 5 --format="%H%n%ad%n%B---" --date=short 2>/dev/null'

  local prompt = vim.fn.readfile(vim.fn.expand '~/projects/bash/opencode-afk/prompt.md')

  local full_prompt = 'Previous commits:\n'
    .. table.concat(commits, '\n')
    .. '\n\nIssues:\n'
    .. table.concat(issues, '\n')
    .. '\n\n'
    .. table.concat(prompt, '\n')

  local sc = require 'sidekick.cli'
  sc.toggle { name = 'opencode', focus = true }
  sc.send { msg = full_prompt, submit = true }
end, { desc = 'Open[C]ode [O]ne issue' })
