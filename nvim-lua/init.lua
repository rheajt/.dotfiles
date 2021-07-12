-- settings contains basic nvim settings
require "settings"
-- all keymaps
require "keymaps"
-- plugins
require "plugins"

-- function _G.howdy()
--     local settings = require'lang-server-settings'
--     local servers = require'lspinstall'.installed_servers()
--     for _, server in pairs(servers) do
--         if(settings[server]) then
--             print(settings[server])
--         end
--     end
--     return
-- end
