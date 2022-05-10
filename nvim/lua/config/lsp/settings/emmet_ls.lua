local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

print("emmet-ls")
local opts = {
    capabilities = capabilities,
	filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
}

return opts
