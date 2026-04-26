defer_plugin({
	packs = {
		{
			src = "https://github.com/obsidian-nvim/obsidian.nvim",
			version = vim.version.range("*"), -- use latest release, remove to use latest commit
		},
	},
	event = { "UIEnter", "BufReadPre", "BufNewFile" },
	setup = function()
		_G.ensure_blink()
		require("obsidian").setup({
			legacy_commands = false,
			dir = "~/google_drive/Obsidian",
			completion = {
				min_chars = 1,
			},
			picker = {
				name = "blink",
			},
			templates = {
				folder = "templates", -- Folder where templates are stored
				date_format = "YYYY-MM-DD", -- Date format for substitutions
				time_format = "HH:mm", -- Time format for substitutions
				substitutions = {}, -- Custom substitutions if needed
			},
			daily_notes = {
				folder = "01_journal",
				date_format = "%Y-%m-%d",
				default_tags = { "journal" },
				template = "daily.md",
			},
		})
		vim.keymap.set("n", "<leader><CR>", require("obsidian.api").smart_action, { buffer = true })
		vim.keymap.set("n", "<leader>nd", function()
			require("obsidian.api").set_checkbox("x")
		end, { buffer = true })
		vim.keymap.set("n", "<leader>nu", function()
			require("obsidian.api").set_checkbox(" ")
		end, { buffer = true })
	end,
})
