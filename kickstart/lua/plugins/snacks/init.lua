return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		dim = { enabled = true },
		explorer = { enabled = true, replace_netrw = true },
		image = require("plugins.snacks.image"),
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = require("plugins.snacks.lazygit"),
		notifier = { enabled = true },
		picker = require("plugins.snacks.picker"),
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "[L]aunch [G]it in Lazygit",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "[S]earch for [F]iles",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[S]earch for [B]uffers",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]earch for [D]iagnostics",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[S]earch for [H]elp",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep({
					follow = true,
					hidden = true,
				})
			end,
			desc = "Search for [G]it files",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[S]earch for [K]eys",
		},
		{
			"<leader>se",
			function()
				Snacks.picker.explorer({
					follow_file = true,
					auto_close = true,
				})
			end,
			desc = "[S]earch file [E]xplorer",
		},
		{
			"<leader>ld",
			function()
				Snacks.dim()
			end,
			desc = "[L]ook at the current scope by [D]imming the rest",
		},
	},
}
