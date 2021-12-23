local lsp_installer = require("nvim-lsp-installer")
-- local lspconfig = require('lspconfig')

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {}

	-- (optional) Customize the options passed to the server
	if server.name == "tsserver" then
		opts.init_options = require("nvim-lsp-ts-utils").init_options
		opts.on_attach = function(client, bufnr)
			-- turn off  formatting for tsserver
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			local ts_utils = require("nvim-lsp-ts-utils")

			-- defaults
			ts_utils.setup({
				debug = false,
				disable_commands = false,
				enable_import_on_completion = false,

				-- import all
				import_all_timeout = 5000, -- ms
				-- lower numbers = higher priority
				import_all_priorities = {
					same_file = 1, -- add to existing import statement
					local_files = 2, -- git files or files with relative path markers
					buffer_content = 3, -- loaded buffer content
					buffers = 4, -- loaded buffer names
				},
				import_all_scan_buffers = 100,
				import_all_select_source = false,

				-- filter diagnostics
				filter_out_diagnostics_by_severity = {},
				filter_out_diagnostics_by_code = {},

				-- inlay hints
				auto_inlay_hints = true,
				inlay_hints_highlight = "Comment",

				-- update imports on file move
				update_imports_on_move = false,
				require_confirmation_on_move = false,
				watch_dir = nil,
			})

			-- required to fix code action ranges and filter diagnostics
			ts_utils.setup_client(client)

			-- no default maps, so you may want to define some here
			local nOpts = { silent = true }
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", nOpts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", nOpts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", nOpts)
		end
	end

	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
			},
		}
	end

	if server.name == "jsonls" then
		local jsonls_opts = require("config.lsp.jsonls")
		-- TODO: remove print(jsonls_opts)
		-- print(jsonls_opts)
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
