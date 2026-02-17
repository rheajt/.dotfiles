-- 1. Scheme Store
-- 2. LSP Config
-- 2. Trouble

return {
	{
		"b0o/schemastore.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} }, -- NOTE: Must be loaded before dependants
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("gca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

					-- Find references for the word under your cursor.
					map("grr", Snacks.picker.lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gri", Snacks.picker.lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("gs", Snacks.picker.lsp_symbols, "Open Document [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map("gw", Snacks.picker.lsp_workspace_symbols, "Open [W]orkspace Symbols")

					-- open hover window
					map("gh", vim.lsp.buf.hover, "[G]o to [H]over")

					map("gof", function()
						vim.diagnostic.open_float(nil, {
							scope = "line",
							close_events = {
								"CursorMoved",
								"CursorMovedI",
								"BufHidden",
								"InsertCharPre",
								"WinLeave",
							},
						})
					end, "[G]o to the [O]pen [F]loat")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("gtd", Snacks.picker.lsp_type_definitions, "[G]oto [T]ype [D]efinition")

					---@diagnostic disable-next-line: undefined-field
					map("gtc", Snacks.picker.todo_comments, "[G]oto [T]odo [C]omments")

					-- Diagnostic keymaps
					map("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")
					map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

					local wk = require("which-key")
					wk.add({
						{ "grn", desc = "LSP: [R]e[n]ame" },
						{ "gca", desc = "LSP: [G]oto Code [A]ction", mode = { "n", "x" } },
						{ "grr", desc = "LSP: [G]oto [R]eferences" },
						{ "gri", desc = "LSP: [G]oto [I]mplementation" },
						{ "gd", desc = "LSP: [G]oto [D]efinition" },
						{ "gD", desc = "LSP: [G]oto [D]eclaration" },
						{ "gs", desc = "LSP: Open Document [S]ymbols" },
						{ "gw", desc = "LSP: Open [W]orkspace Symbols" },
						{ "gh", desc = "LSP: [G]o to [H]over" },
						{ "gof", desc = "LSP: [G]o to the [O]pen [F]loat" },
						{ "gtd", desc = "LSP: [G]oto [T]ype [D]efinition" },
						{ "gtc", desc = "LSP: [G]oto [T]odo [C]omments" },
						{ "<leader>e", desc = "LSP: Show diagnostic [E]rror messages" },
						{ "<leader>q", desc = "LSP: Open diagnostic [Q]uickfix list" },
					}, { buffer = event.buf })

					-- TODO: remove i think this is not needed anymore
					-- map("gK", function()
					-- 	local new_config = not vim.diagnostic.config().virtual_lines
					-- 	vim.diagnostic.config({ virtual_lines = new_config })
					-- end, "Toggle diagnostic virtual_lines")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						-- if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
						-- else
						-- 	return client.supports_method(method, { bufnr = bufnr })
						-- end
					end

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = function()
								vim.lsp.buf.document_highlight()
							end,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")

						wk.add({
							{ "<leader>th", desc = "LSP: [T]oggle Inlay [H]ints" },
						}, { buffer = event.buf })
					end
				end,
			}) -- end of the autocommand

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			-- Set highlight for unused variables (gray)
			vim.api.nvim_set_hl(0, "DiagnosticUnused", { fg = "#888888" })

			vim.diagnostic.config({
				severity_sort = true,
				float = {
					max_width = 80,
					border = "rounded",
					source = "if_many",
					format = function(diagnostic)
						if
							diagnostic.code == "unused-local"
							or diagnostic.code == "unused-variable"
							or diagnostic.code == "unused"
						then
							return diagnostic.message
						end
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
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
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					max_width = 50,
					format = function(diagnostic)
						-- Show unused variables in gray
						if
							diagnostic.code == "unused-local"
							or diagnostic.code == "unused-variable"
							or diagnostic.code == "unused"
						then
							return diagnostic.message
						end
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
				code_lens = {
					enable = true,
				},
			})

			local servers = {
				eslint_d = {},
				copilot = {},
				graphql = {},
				sqlls = {},
				gopls = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								disable = { "missing-fields" },
								globals = { "vim" },
							},
						},
					},
				},
				emmet_language_server = {},
				html = {},
				cssls = {},
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
								-- You must disable built-in schemaStore support if you want to use
								-- this plugin and its advanced options like `ignore`.
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
				stylua = {},
				lemminx = {},
				xmlformatter = {},
				beautysh = {},
				bashls = { filetypes = { "bash", "zsh" } },
				cssmodules_ls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
					init_options = {
						-- Keep class name completion aligned with CSS dashes
						camelCase = "dashes",
					},
				},
			}

			-- local ensure_installed = vim.tbl_keys(servers or {})
			-- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			for server, cfg in pairs(servers) do
				-- print("Configuring LSP server: " .. server)
				cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
				vim.lsp.config(server, cfg)
				vim.lsp.enable(server)
			end
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				-- spawn additional tsserver instance to calculate diagnostics on it
				separate_diagnostic_server = true,
				-- "change"|"insert_leave" determine when the client asks the server about diagnostic
				publish_diagnostic_on = "insert_leave",
				-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
				-- "remove_unused_imports"|"organize_imports") -- or string "all"
				-- to include all supported code actions
				-- specify commands exposed as code_actions
				expose_as_code_action = {},
				-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
				-- not exists then standard path resolution strategy is applied
				tsserver_path = nil,
				-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
				-- (see 💅 `styled-components` support section)
				tsserver_plugins = {},
				-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
				-- memory limit in megabytes or "auto"(basically no limit)
				tsserver_max_memory = "auto",
				-- described below
				tsserver_format_options = {},
				tsserver_file_preferences = {},
				-- locale of all tsserver messages, supported locales you can find here:
				-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
				tsserver_locale = "en",
				-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
				complete_function_calls = false,
				include_completions_with_insert_text = true,
				-- CodeLens
				-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
				-- possible values: ("off"|"all"|"implementations_only"|"references_only")
				code_lens = "off",
				-- by default code lenses are displayed on all referencable values and for some of you it can
				-- be too much this option reduce count of them by removing member references from lenses
				disable_member_code_lens = true,
				-- JSXCloseTag
				-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
				-- that maybe have a conflict if enable this feature. )
				jsx_close_tag = {
					enable = false,
					filetypes = { "javascriptreact", "typescriptreact" },
				},
			},
		},
	},
}
