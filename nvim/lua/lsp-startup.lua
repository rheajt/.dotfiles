local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require('lspconfig')

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    if server.name == "efm" then
        print(server.name)
        opts.root_dir = require'lspconfig/util'.root_pattern('package.json', '.eslintrc', '.git')
    end

    if server.name == "jsonls" then
        print(server.name)
        opts.settings = {
            Json = {
                schemas = {
                   {
                       fileMatch = { "package.json" };
                       url = "https://json.schemastore.org/package.json"
                   }
               }
           }
       }
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

