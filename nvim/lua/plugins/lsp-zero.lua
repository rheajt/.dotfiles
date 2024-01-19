-- function DiagnosticNext()
-- end

return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
	},
	-- config = function()
	-- vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)
	-- vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
	-- vim.keymap.set("n", "gl", vim.lsp.diagnostic.get_line_diagnostics)

	-- -- vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
	-- vim.keymap.set("n", "gh", "<cmd>Telescope diagnostic<CR>")
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition)
	-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
	-- vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover)
	-- vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action)
	-- end,
}
