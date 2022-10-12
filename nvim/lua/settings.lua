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

vim.o.cursorline = true
vim.opt.background = "dark" -- or "light" for light mode
vim.cmd([[ colorscheme gruvbox-baby ]])
vim.g.gruvbox_baby_telescope_theme = 1
vim.g.gruvbox_baby_background_color = "dark"

-- vim.api.nvim_set_hl(0, "Normal", {
-- 	bg = "none",
-- })

-- vim.api.nvim_set_hl(0, "NonText", {
-- 	bg = "none",
-- })

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
-- vim.opt.shell = "/bin/bash"

vim.opt.showtabline = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
