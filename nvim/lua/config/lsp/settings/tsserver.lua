local opts = {}

opts.on_attach = function(client, bufnr)
	-- turn off  formatting for tsserver
	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false
end

return opts
