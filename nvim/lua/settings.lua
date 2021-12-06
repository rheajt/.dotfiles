--settings file
vim.o.colorcolumn = "100"
vim.g.mapleader = " "
vim.o.termguicolors = true
vim.cmd("colorscheme gruvbox")
vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_sign_column = "bg0"
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.o.mouse = "a"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.g.smarttab = true
vim.go.cmdheight = 2
vim.o.showmode = false
vim.o.showtabline = 2
vim.o.hlsearch = false
vim.o.scrolloff = 8
vim.o.shell = "/bin/bash"

vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.ts,*.tsx,*.js,*.jsx,*.lua FormatWrite
augroup END
]],
	true
)
