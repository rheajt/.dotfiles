-- Add indentation guides even on blank lines

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help ibl`
vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }

local hooks = require 'ibl.hooks'

hooks.register(hooks.type.HIGHLIGHT_SETUP, function() vim.api.nvim_set_hl(0, 'IblScopeDim', { fg = '#3b3b3b' }) end)

require('ibl').setup {
  indent = {
    char = '',
    tab_char = '',
  },
  scope = {
    enabled = true,
    char = '│',
    highlight = 'IblScopeDim',
    show_start = false,
    show_end = false,
  },
}
