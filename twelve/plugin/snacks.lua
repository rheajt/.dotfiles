-- Snacks is deferred to UIEnter. Features like statuscolumn and indent will
-- render on the first redraw after UIEnter (imperceptible delay). The explorer
-- replace_netrw option triggered a costly OptionSet cascade at VimEnter (~52ms);
-- deferring to UIEnter avoids that startup bottleneck.
--
-- Keymaps are defined eagerly but use Snacks.* which becomes available after
-- UIEnter fires (all keymaps are user-initiated so there is no race).

vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})
require("snacks").setup({
	bigfile = { enabled = true },
	dim = { enabled = false },
	explorer = { enabled = true, replace_netrw = true },
	image = {
		enabled = true,
		doc = {
			-- enable image viewer for documents
			-- a treesitter parser must be available for the enabled languages.
			enabled = true,
			-- render the image inline in the buffer
			-- if your env doesn't support unicode placeholders, this will be disabled
			-- takes precedence over `opts.float` on supported terminals
			inline = false,
			-- render the image in a floating window
			-- only used if `opts.inline` is disabled
			float = true,
			max_width = 80,
			max_height = 40,
			-- Set to `true`, to conceal the image text when rendering inline.
			conceal = false, -- (experimental)
		},
	},
	indent = { enabled = true },
	input = { enabled = true },
	lazygit = { enabled = true },
	notifier = { enabled = true },
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = {
		enabled = true,
		exclude = {
			"notify",
			"noice",
			"lazy",
			"mason",
			"Trouble",
		},
	},
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})
vim.opt_local.conceallevel = 2

vim.keymap.set("n", "<leader>lg", function()
	Snacks.lazygit()
end, { desc = "[L]aunch [G]it in Lazygit" })

vim.keymap.set("n", "<leader>sf", function()
	Snacks.picker.files()
end, { desc = "[S]earch for [F]iles" })

vim.keymap.set("n", "<leader>sb", function()
	Snacks.picker.buffers()
end, { desc = "[S]earch for [B]uffers" })

vim.keymap.set("n", "<leader>sd", function()
	Snacks.picker.diagnostics()
end, { desc = "[S]earch for [D]iagnostics" })

vim.keymap.set("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "[S]earch for [H]elp" })

vim.keymap.set("n", "<leader>sg", function()
	Snacks.picker.grep({
		follow = true,
		hidden = true,
	})
end, { desc = "Search for [G]it files" })

vim.keymap.set({ "n", "v" }, "<leader>sc", function()
	Snacks.picker.grep_word()
end, { desc = "[S]earch for current [C]word under cursor" })

vim.keymap.set("n", "<leader>se", function()
	Snacks.picker.explorer({
		follow_file = true,
		auto_close = true,
	})
end, { desc = "[S]earch file [E]xplorer" })
