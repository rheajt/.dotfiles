local lsp = require("lsp-zero")
-- local cmp = require('cmp')

lsp.preset({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = "local",
    sign_icons = {
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "",
    },
})

lsp.ensure_installed({
    "tsserver",
    "jsonls",
})

local tsserver_settings = require("config.lsp.settings.tsserver")
lsp.configure("tsserver", tsserver_settings)

local json_settings = require("config.lsp.settings.jsonls")
lsp.configure("jsonls", json_settings)

local lua_settings = require("config.lsp.settings.sumneko_lua")
lsp.configure("lua-language-server", lua_settings)

lsp.on_attach(function(client, bufnr)
    -- print("lsp lua attached")
    client.server_capabilities.semanticTokensProvider = nil
end)

lsp.nvim_workspace()
lsp.setup()
