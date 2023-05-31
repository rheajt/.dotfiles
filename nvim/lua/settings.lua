vim.opt.cursorline = true

vim.g.gruvbox_baby_function_style = "NONE"
vim.g.gruvbox_baby_keyword_style = "italic"
vim.g.gruvbox_baby_highlights = { Normal = { fg = "#123123", bg = "NONE", style = "underline" } }
vim.g.gruvbox_baby_telescope_theme = 1
vim.g.gruvbox_baby_transparent_mode = 1
vim.cmd("colorscheme gruvbox-baby")
vim.opt.background = "dark" -- or "light" for light mode
vim.api.nvim_set_hl(0, "Normal", {
    bg = "none",
})

vim.api.nvim_set_hl(0, "NonText", {
    bg = "none",
})

vim.opt.clipboard = "unnamedplus"
vim.g.copilot_no_tab_map = true

--settings file
vim.opt.colorcolumn = "100"
vim.opt.fileencoding = "utf-8"

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
