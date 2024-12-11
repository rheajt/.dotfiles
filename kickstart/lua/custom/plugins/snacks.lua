return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scratch = {
			name = "ScratchPad",
			ft = function()
				if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
					return vim.bo.filetype
				end
				return "markdown"
			end,
			win = { style = "scratch" },
			---@type table<string, snacks.win.Config>
			win_by_ft = {
				lua = {
					keys = {
						["source"] = {
							"<cr>",
							function(self)
								local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
								Snacks.debug.run({ buf = self.buf, name = name })
							end,
							desc = "Source buffer",
							mode = { "n", "x" },
						},
					},
				},
			},
		},
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		zen = { enabled = true },
	},
	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>,",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
