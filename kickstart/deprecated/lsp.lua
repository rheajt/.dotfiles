return {
	"neovim/nvim-lspconfig",
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{
			"b0o/schemastore.nvim",
			config = function()
				local lspconfig = require("lspconfig")
				lspconfig.jsonls.setup({
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				})
				lspconfig.yamlls.setup({
					settings = {
						yaml = {
							schemaStore = {
								-- You must disable built-in schemaStore support if you want to use
								-- this plugin and its advanced options like `ignore`.
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				})
			end,
		},
		{ "mason-org/mason.nvim", opts = {} }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {},
			config = function()
				require("typescript-tools").setup({
					settings = {
						tsserver_plugins = {
							"@styled/typescript-styled-plugin",
						},
					},
				})
			end,
		},
	},
	-- example using `opts` for defining servers
	opts = {
		servers = {
			sqlls = {},
			lua_ls = {},
			-- vtsls = {},
			["typescript-tools"] = {},
			emmet_language_server = {},
			html = {},
			cssls = {},
			eslint = {},
			cssmodules_ls = {
				init_options = {
					camelCase = "dashes",
				},
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")

		for server, config in pairs(opts.servers) do
			print(server .. " connected")
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities()
			config.capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig[server].setup(config)
		end

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Do[K]umentation" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "[G]oto [T]ype Definition" })
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "[G]oto [S]ignature" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
	end,
}
