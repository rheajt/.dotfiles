return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		enabled = true,
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				filetypes = {
					neorg = false,
				},
				suggestion = { enabled = true, auto_trigger = true },
				-- panel = { enabled = false },
			})

			vim.keymap.set("i", "<right>", function()
				require("copilot.suggestion").accept()
			end, { desc = "Accept Copilot suggestion" })
			vim.keymap.set("i", "<up>", function()
				require("copilot.suggestion").next()
			end, { desc = "Next Copilot Suggestion" })
			vim.keymap.set("i", "<down>", function()
				require("copilot.suggestion").prev()
			end, { desc = "Prev Copilot Suggestion" })
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- add any opts here
			-- for example
			provider = "openai",
			providers = {
				openai = {
					endpoint = "https://api.openai.com/v1",
					model = "gpt-4o-mini", -- your desired model (or use gpt-4o, etc.)
					timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
					extra_request = {
						temperature = 0,
						max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
						reasoning_effort = "high", -- low|medium|high, only used for reasoning models
					},
				},
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}
