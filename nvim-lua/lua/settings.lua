--settings file
vim.g.mapleader = ' '

vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 30

vim.o.termguicolors = true
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'
vim.cmd("colorscheme gruvbox")

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

vim.o.mouse = 'a'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.hlsearch = false

vim.o.scrolloff = 8
vim.o.hidden = true

-- KEYBINDINGS
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {
	noremap = true
})

vim.api.nvim_set_keymap('n', '<leader><Enter>', ':so %<CR>', {
	noremap = true
})
