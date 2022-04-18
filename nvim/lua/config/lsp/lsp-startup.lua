local lsp_installer = require("nvim-lsp-installer")
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {}
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	opts.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

	-- (optional) Customize the options passed to the server
	if server.name == "tsserver" then
		local tsserver_opts = require("config.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_lua_opts = require("config.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_lua_opts, opts)
	end

	if server.name == "jsonls" then
		local jsonls_opts = require("config.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "html" then
		local html_opts = require("config.lsp.settings.html")
		opts = vim.tbl_deep_extend("force", html_opts, opts)
	end

	-- if server.name == "gopls" then
	-- 	local go_opts = require("config.lsp.settings.gopls")
	-- 	opts = vim.tbl_deep_extend("force", go_opts, opts)
	-- end
	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
