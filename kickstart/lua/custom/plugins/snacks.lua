return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		dim = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = {
			-- automatically configure lazygit to use the current colorscheme
			-- and integrate edit with the current neovim instance
			configure = true,
			-- extra configuration for lazygit that will be merged with the default
			-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
			-- you need to double quote it: `"\"test\""`
			config = {
				os = { editPreset = "nvim-remote" },
				gui = {
					-- set to an empty string "" to disable icons
					nerdFontsVersion = "3",
				},
			},
			theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
			-- Theme for lazygit
			theme = {
				[241] = { fg = "Special" },
				activeBorderColor = { fg = "MatchParen", bold = true },
				cherryPickedCommitBgColor = { fg = "Identifier" },
				cherryPickedCommitFgColor = { fg = "Function" },
				defaultFgColor = { fg = "Normal" },
				inactiveBorderColor = { fg = "FloatBorder" },
				optionsTextColor = { fg = "Function" },
				searchingActiveBorderColor = { fg = "MatchParen", bold = true },
				selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
				unstagedChangesColor = { fg = "DiagnosticError" },
			},
			win = {
				style = "lazygit",
			},
		},
		notifier = { enabled = true },
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
			"<leader>ld",
			function()
				Snacks.dim()
			end,
			{ desc = "[L]ook at the current scope by [D]imming the rest" },
		},
	},
}
