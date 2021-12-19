local nls = require("null-ls")

nls.setup({
	sources = {
		nls.builtins.formatting.stylua,
		nls.builtins.formatting.prettier,
		nls.builtins.diagnostics.tsc,
		nls.builtins.completion.luasnip,
		nls.builtins.code_actions.refactoring,
	},

	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
