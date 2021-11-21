--settings file
vim.g.mapleader = ' '

vim.o.termguicolors = true

vim.cmd("colorscheme gruvbox")
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

vim.o.mouse = 'a'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.smarttab = true

vim.g.showmode = false

vim.o.hlsearch = false

vim.o.scrolloff = 8

vim.api.nvim_exec([[
    autocmd BufWritePre *.ts,*tsx lua vim.lsp.buf.formatting_sync(nil, 1000)
]], true)
