vim.opt.cursorline = true

require("kanagawa").setup({
	compile = false, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = false, -- do not set background color
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = {          -- add/modify theme and palette colors
		palette = {},
		theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	},
	overrides = function(colors) -- add/modify highlights
		local theme = colors.theme
		return {
			TelescopeTitle = { fg = theme.ui.special, bold = true },
			TelescopePromptNormal = { bg = theme.ui.bg_p1 },
			TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
			TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
			TelescopePreviewNormal = { bg = theme.ui.bg_dim },
			TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
			LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		}
	end,
	theme = "wave", -- Load "wave" theme when 'background' option is not set
	background = { -- map the value of 'background' option to a theme
		dark = "dragon", -- try "dragon" !
		light = "lotus",
	},
})

vim.o.background = ""
vim.cmd("colorscheme kanagawa-dragon")

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

-- vim.opt.expandtab = true
-- vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
-- vim.opt.smartindent = true

vim.opt.cmdheight = 2

vim.opt.showmode = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
-- vim.opt.shell = "/bin/bash"

vim.opt.showtabline = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
