return {
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
