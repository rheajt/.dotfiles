vim.pack.add {
  'https://github.com/niqodea/lasso.nvim',
}

local lasso = require 'lasso'

lasso.setup {
  -- Whether to highlight the text of the target window when lassoing
  highlight = true,
  -- The highlight group to use for the target window
  highlight_group = 'Visual',
  -- Whether to show a border around the target window when lassoing
  border = true,
  -- The border style to use for the target window
  border_style = 'rounded',
  -- Whether to show a preview of the target window when lassoing
  preview = true,
  -- The position of the preview window relative to the target window
  preview_position = 'right',
}

-- Mark current file
vim.keymap.set('n', vim.g.mapleader .. 'mf', function() lasso.mark_file() end)

-- Go to marks tracker (editable, use `gf` to go to file under cursor)
vim.keymap.set('n', vim.g.mapleader .. 'M', function() lasso.open_marks_tracker() end)

-- Jump to n-th marked file (n-th line of marks tracker)
vim.keymap.set('n', vim.g.mapleader .. 'm1', function() lasso.open_marked_file(1) end)
vim.keymap.set('n', vim.g.mapleader .. 'm2', function() lasso.open_marked_file(2) end)
vim.keymap.set('n', vim.g.mapleader .. 'm3', function() lasso.open_marked_file(3) end)
vim.keymap.set('n', vim.g.mapleader .. 'm4', function() lasso.open_marked_file(4) end)
