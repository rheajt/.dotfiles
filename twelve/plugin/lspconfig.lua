-- ============================================================================
-- Plugins
-- ============================================================================

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/b0o/schemastore.nvim",
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
})

-- ============================================================================
-- Mason (installer for LSP servers, linters, formatters)
-- ============================================================================

require("mason").setup({})

-- ============================================================================
-- Completion (blink.cmp)
-- ============================================================================

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<Up>"] = {},
		["<Down>"] = {},
	},
	appearance = {
		nerd_font_variant = "mono",
		kind_icons = {
			["Copilot"] = "",
			["Snip"] = "",
			["Snippet"] = "",
		},
	},
	completion = {
		menu = {
			border = "single",
			draw = {
				padding = { 2, 2 },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			window = {
				border = "single",
			},
		},
		ghost_text = {
			enabled = false,
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "lua",
	},
})

-- ============================================================================
-- LSP Servers
-- ============================================================================

local servers = {
	-- AI
	copilot_ls = {},

	-- Go
	gopls = {},

	-- Lua
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					disable = { "missing-fields" },
					globals = { "vim", "Snacks" },
				},
			},
		},
	},

	-- JavaScript / TypeScript
	vtsls = {
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
	eslint = {},
	cssmodules_ls = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		init_options = {
			camelCase = "dashes",
		},
	},

	-- Web
	html = {},
	cssls = {},
	emmet_language_server = {},
	graphql = {},

	-- Data / Config
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
	lemminx = {},

	-- SQL
	sqlls = {},

	-- Shell
	bashls = { filetypes = { "bash", "zsh" } },
}

local capabilities = require("blink.cmp").get_lsp_capabilities()

for server, cfg in pairs(servers) do
	cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
	vim.lsp.config(server, cfg)
	vim.lsp.enable(server)
end

-- ============================================================================
-- LSP Keymaps (on attach)
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("twelve-lsp-attach", { clear = true }),
	callback = function(ev)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
		end

		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
		map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gh", vim.lsp.buf.hover, "[G]o to [H]over")

		map("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")
		map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

		map("<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
		end, "[T]oggle Inlay [H]ints")

		-- Highlight references of the word under cursor
		local highlight_augroup = vim.api.nvim_create_augroup("twelve-lsp-highlight", { clear = false })

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = ev.buf,
			group = highlight_augroup,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = ev.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("twelve-lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "twelve-lsp-highlight", buffer = event2.buf })
			end,
		})
	end,
})

-- ============================================================================
-- Diagnostics
-- ============================================================================

vim.api.nvim_set_hl(0, "DiagnosticUnused", { fg = "#888888" })

vim.diagnostic.config({
	severity_sort = true,
	float = {
		max_width = 80,
		border = "rounded",
		source = "if_many",
	},
	underline = true,
	wrap = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	virtual_text = {
		source = "if_many",
		spacing = 2,
	},
	code_lens = {
		enable = true,
	},
})
