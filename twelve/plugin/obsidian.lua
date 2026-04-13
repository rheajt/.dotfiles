defer_plugin({
	packs = {
		{
			src = "https://github.com/obsidian-nvim/obsidian.nvim",
			version = vim.version.range("*"), -- use latest release, remove to use latest commit
		},
	},
	event = "BufEnter",
	pattern = "*.md",
	setup = function()
		require("obsidian").setup({
			legacy_commands = false,
			dir = "~/google_drive/Obsidian",
			picker = {
				name = "blink",
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
