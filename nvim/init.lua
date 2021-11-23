require "plugins"
-- settings contains basic nvim settings
require "settings"
-- all keymaps
require "keymaps"

function _G.howdy()
    local settings = require'lang-server-settings'
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
        if(settings[server]) then
            print(server)
        end
    end
    return
end
