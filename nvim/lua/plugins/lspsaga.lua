return {
	-- enabled = false,
	"glepnir/lspsaga.nvim",
	event = "BufRead",
	config = function()
		require("lspsaga").setup({
			diagnostic = {
				on_insert = false,
			},
			lightbulb = {
				enable = false,
			},
			code_action = {
				num_shortcut = true,
				keys = {
					quit = "q",
					exec = "<CR>",
				},
			},
		})

		vim.keymap.set("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		vim.keymap.set("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>")
		vim.keymap.set("n", "gc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

		vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
		vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
		vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
		vim.keymap.set({ "n", "v" }, "K", "<cmd>Lspsaga hover_doc<CR>")
		vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>")
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		--Please make sure you install markdown and markdown_inline parser
		{ "nvim-treesitter/nvim-treesitter" },
	},
}
