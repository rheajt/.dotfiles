return {
    on_attach = function(client)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
    end,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
}
