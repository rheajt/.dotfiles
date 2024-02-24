return {
	{
		"samharju/synthweave.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000,
		config = function()
			local synthweave = require("synthweave")
			synthweave.setup({
				transparent = true,
				palette = {
					-- override palette colors, take a peek at synthweave/palette.lua
					bg0 = "#040404",
				},
			})
			synthweave.load()
		end,
	},
	"luisiacc/gruvbox-baby",
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
