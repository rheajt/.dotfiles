return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		dim = { enabled = true },
		explorer = { enabled = true, replace_netrw = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = require("custom.plugins.snacks.lazygit"),
		notifier = { enabled = true },
		picker = require("custom.plugins.snacks.picker"),
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			{ desc = "Search for [F]iles" },
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			{ desc = "Search for [B]uffers" },
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			{ desc = "Search for [H]elp" },
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep({
					follow = true,
					hidden = true,
				})
			end,
			{ desc = "Search for [G]it files" },
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			{ desc = "[S]earch for [K]eys" },
		},
		{
			"<leader>se",
			function()
				Snacks.picker.explorer({
					follow_file = true,
					auto_close = true,
				})
			end,
			{ desc = "[S]earch file [E]xplorer" },
		},
		{
			"<leader>ld",
			function()
				Snacks.dim()
			end,
			{ desc = "[L]ook at the current scope by [D]imming the rest" },
		},
	},
}
