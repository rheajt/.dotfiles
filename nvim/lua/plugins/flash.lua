-- local flash = require("flash")

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		mode = function(str)
			return "\\<" .. string.lower(str)
		end,
	},
	-- stylua: ignore
	keys = {
		{
			"<leader>ls",
			mode = { "n", "x", "o" },
			function()
				local gi = vim.go.ignorecase
				local gs = vim.go.smartcase
				vim.go.ignorecase = true
				vim.go.smartcase = false
				require('flash').jump()
				vim.go.ignorecase = gi
				vim.go.smartcase = gs
			end,
			desc = "Flash"
		},
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
