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
	end,
})
