local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.prettierd,
	null_ls.builtins.formatting.gofmt,
	null_ls.builtins.diagnostics.tsc,
	null_ls.builtins.completion.luasnip,
}

null_ls.setup({
	sources = sources,
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
		end
	end,
})
