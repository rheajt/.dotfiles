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
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
	},
	-- example using `opts` for defining servers
	opts = {
		-- settings = {
		-- 	json = {
		-- 		schemas = require("schemastore").json.schemas(),
		-- 		validate = true,
		-- 	},
		-- 	yaml = {
		-- 		schemaStore = {
		-- 			enable = false,
		-- 			url = "",
		-- 		},
		-- 		schemas = require("schemastore").yaml.schemas(),
		-- 	},
		-- },
		servers = {
			sqls = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Both",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = {
							globals = { "vim", "Snacks", "snacks" },
							disable = { "missing-fields" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			vtsls = {},
			emmet_language_server = {},
			html = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")

		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			-- config.capabilities = require("blink.cmp").get_lsp_capabilities()
			lspconfig[server].setup(config)
		end

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Do[K]umentation" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
	end,
}
