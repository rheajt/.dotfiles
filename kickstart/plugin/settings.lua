-- vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars = {
	eob = " ",
	vert = "┃",
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes:2"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.textwidth = 100
vim.opt.laststatus = 3
vim.o.winborder = "none"
-- `vim.ui.select` is not set to `Snacks.picker.select`
vim.ui.select = Snacks.picker.select

-- Set transparent background for Blink completion menu only
vim.api.nvim_set_hl(0, "BlinkCompletionNormal", { bg = "NONE" })

print("settings loaded")
