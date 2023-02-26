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
    "lua_ls",
})

-- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
-- local lsp_format_on_save = function(bufnr)
--     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--     vim.api.nvim_create_autocmd('BufWritePre', {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--             vim.lsp.buf.format()
--         end,
--     })
-- end

-- lsp.on_attach(function(client, bufnr)
--     lsp_format_on_save(bufnr);
-- end)
-- lsp.setup_nvim_cmp({
--     sources = {
--         { name = "neorg" }
--     }
-- })

-- lsp.configure('tsserver', {
--     on_attach = function(client, bufnr)
--         print('hello tsserver')
--         client.server_capabilities.document_formatting = true
--         client.server_capabilities.document_range_formatting = true
--     end,
--     settings = {
--         completions = {
--             completeFunctionCalls = true
--         }
--     }
-- })

lsp.nvim_workspace()
lsp.setup()
