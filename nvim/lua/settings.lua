vim.g.mapleader = " "

vim.cmd([[
set clipboard+=unnamedplus
let g:clipboard = {
  \   'name': 'win32yank-wsl',
  \   'copy': {
  \      '+': 'win32yank.exe -i --crlf',
  \      '*': 'win32yank.exe -i --crlf',
  \    },
  \   'paste': {
  \      '+': 'win32yank.exe -o --lf',
  \      '*': 'win32yank.exe -o --lf',
  \   },
  \   'cache_enabled': 0,
  \ }
]])

vim.opt.background = "dark" -- or "light" for light mode
-- colorscheme kanagawa
vim.cmd([[
    set cursorline
    colorscheme gruvbox
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none

    highlight Normal guibg=none
    highlight NonText guibg=none
]])

--settings file
vim.opt.colorcolumn = "100"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.mouse = "a"

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.cmdheight = 2

vim.opt.showmode = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.shell = "/bin/bash"

vim.opt.showtabline = 0
vim.opt.splitbelow = true
vim.opt.splitright = true
