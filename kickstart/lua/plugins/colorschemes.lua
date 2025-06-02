return {
	{
		"luisiacc/gruvbox-baby",
		priority = 1000,
		init = function()
			vim.g.gruvbox_baby_keyword_style = "italic"
			vim.g.gruvbox_baby_transparent_mode = 1
			-- vim.cmd.colorscheme("gruvbox-baby")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			-- Default options:
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"mtendekuyokwa19/stoics.nvim",
		config = function()
			-- vim.cmd("colorscheme stoics")
		end,
	},
}
