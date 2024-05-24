-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md

return {
	--- Uncomment the two plugins below if you want to manage the language servers from neovim
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim", config = function() end },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig", version = false },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },

	-- OLD
	-- "VonHeikemen/lsp-zero.nvim",
	-- dependencies = {
	-- 	-- LSP Support
	-- 	{ "neovim/nvim-lspconfig" },
	-- 	{ "williamboman/mason.nvim" },
	-- 	{ "williamboman/mason-lspconfig.nvim" },

	-- 	-- Autocompletion
	-- 	{ "hrsh7th/nvim-cmp" },
	-- 	{ "hrsh7th/cmp-buffer" },
	-- 	{ "hrsh7th/cmp-path" },
	-- 	{ "saadparwaiz1/cmp_luasnip" },
	-- 	{ "hrsh7th/cmp-nvim-lsp" },
	-- 	{ "hrsh7th/cmp-nvim-lua" },

	-- 	-- Snippets
	-- 	{ "L3MON4D3/LuaSnip" },
	-- 	{ "rafamadriz/friendly-snippets" },
	-- },
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
