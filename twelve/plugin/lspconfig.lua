-- ============================================================================
-- LSP Configuration (deferred to first buffer read)
-- ============================================================================

-- Diagnostics config is cheap and should be available immediately
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

-- ============================================================================
-- Mason (deferred -- only loads when you run :Mason)
-- ============================================================================

-- Prepend Mason's bin directory to PATH eagerly so LSP servers installed
-- via Mason are found by vim.lsp.enable(). This is just a string concat
-- (near-zero cost). The actual mason.nvim plugin/UI stays deferred.
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 then
	vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

vim.api.nvim_create_user_command("Mason", function()
	vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
	require("mason").setup({})
	vim.cmd("Mason")
end, {})

-- ============================================================================
-- Completion (blink.cmp -- deferred to InsertEnter)
-- ============================================================================

local blink_loaded = false

local function ensure_blink()
	if blink_loaded then
		return
	end
	blink_loaded = true

	vim.pack.add({
		{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
		"https://github.com/rafamadriz/friendly-snippets",
	})

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
end

vim.api.nvim_create_autocmd("InsertEnter", {
	group = vim.api.nvim_create_augroup("twelve-blink-defer", { clear = true }),
	once = true,
	callback = ensure_blink,
})

-- ============================================================================
-- LSP Servers (deferred to first buffer read)
-- ============================================================================

local lsp_loaded = false

local function ensure_lsp()
	if lsp_loaded then
		return
	end
	lsp_loaded = true

	vim.pack.add({
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/b0o/schemastore.nvim",
	})

	ensure_blink()

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
		html = {
			filetypes = { "html", "hbs", "handlebars" },
			settings = {
				html = {
					format = {
						wrapLineLength = 120,
						unformatted = { "script", "style", "pre" },
					},
				},
			},
		},
		cssls = {
			filetypes = { "css", "scss", "sass" },
		},
		emmet_language_server = {
			filetypes = { "html", "css", "scss", "sass", "javascriptreact", "typescriptreact" },
		},
		graphql = {
			filetypes = { "graphql", "gql" },
		},

		-- Data / Config (schemastore loaded lazily via on_attach)
		jsonls = {
			on_attach = function(client)
				client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				})
				client:notify("workspace/didChangeConfiguration", { settings = client.settings })
			end,
		},
		yamlls = {
			on_attach = function(client)
				client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				})
				client:notify("workspace/didChangeConfiguration", { settings = client.settings })
			end,
		},
		lemminx = {},

		-- SQL
		sqlls = {},

		-- Shell
		bashls = { filetypes = { "bash", "zsh" } },
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	for server, cfg in pairs(servers) do
		local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
		cfg.capabilities = vim.tbl_deep_extend("force", capabilities, blink_capabilities, cfg.capabilities or {})

		vim.lsp.config(server, cfg)
		vim.lsp.enable(server)
	end

	-- Re-trigger filetype detection for all loaded buffers so that servers
	-- attach to the buffer that caused this deferred load (vim.lsp.enable
	-- registers a FileType autocmd, but the current buffer's filetype was
	-- already set before the servers were enabled).
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
			vim.api.nvim_exec_autocmds("FileType", { buffer = buf })
		end
	end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("twelve-lsp-defer", { clear = true }),
	once = true,
	callback = function()
		ensure_lsp()
	end,
})

-- ============================================================================
-- LSP Keymaps & Capabilities (on attach)
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("twelve-lsp-attach", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

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

		-- Highlight references of the word under cursor (only if server supports it)
		if client and client:supports_method("textDocument/documentHighlight") then
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
		end
	end,
})
