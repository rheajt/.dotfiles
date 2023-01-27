local lsp = require("lsp-zero")
-- local cmp = require('cmp')

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
})

-- lsp.setup_nvim_cmp({
--     sources = {
--         { name = "neorg" }
--     }
-- })

lsp.nvim_workspace()
lsp.setup()
