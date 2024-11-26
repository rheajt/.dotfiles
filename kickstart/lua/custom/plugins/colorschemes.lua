return {
	{ -- You can easily change to a different colorscheme.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		opts = {
			transparent = true,
			styles = {
				floats = "transparent",
				sidebars = "transparent",
			},
		},
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-moon")
			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{
		"samharju/synthweave.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000,
		-- config = function()
		-- 	local synthweave = require("synthweave")
		-- 	synthweave.setup({
		-- 		transparent = true,
		-- 		palette = {
		-- 			-- override palette colors, take a peek at synthweave/palette.lua
		-- 			bg0 = "#040404",
		-- 		},
		-- 	})
		-- 	synthweave.load()
		-- end,
	},
	{
		"luisiacc/gruvbox-baby",
		-- priority = 1000,
		-- init = function()
		-- 	vim.g.gruvbox_baby_keyword_style = "italic"
		-- 	vim.g.gruvbox_baby_telescope_theme = 1
		-- 	vim.g.gruvbox_baby_background_color = "dark"
		-- 	vim.g.gruvbox_baby_function_style = "NONE"
		-- 	vim.g.gruvbox_baby_transparent_mode = 1
		--
		-- 	vim.cmd.colorscheme("gruvbox-baby")
		-- 	vim.api.nvim_set_hl(0, "Normal", {
		-- 		bg = "none",
		-- 	})
		--
		-- 	vim.api.nvim_set_hl(0, "NonText", {
		-- 		bg = "none",
		-- 	})
		-- end,
	},
	"sekke276/dark_flat.nvim",
	"rebelot/kanagawa.nvim",
	{
		"loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup({
				filter = "classic",
			})
		end,
	},
}
