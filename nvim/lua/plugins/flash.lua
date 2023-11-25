-- local flash = require("flash")

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	-- stylua: ignore
	keys = {
		{ "<leader>ls", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{
			"<leader>lt",
			mode = { "n", "x", "v" },
			function() require("flash").treesitter() end,
			desc =
			"Flash Treesitter"
		},
		{
			"<leader>lr",
			mode = { "n", "v", "o", "x" },
			function() require("flash").treesitter_search() end,
			desc =
			"Treesitter Search"
		},
		{
			"<c-s>",
			mode = { "c" },
			function() require("flash").toggle() end,
			desc =
			"Toggle Flash Search"
		},
		{
			"<leader>lh",
			mode = { "n", "v" },
			function()
				require('flash').jump({
					pattern = vim.fn.expand("<cword>"),
				})
			end,
		}
	},
}
