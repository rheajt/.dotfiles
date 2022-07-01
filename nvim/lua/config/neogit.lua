local neogit = require("neogit")
local nnoremap = require("config.keymap_binds").nnoremap

neogit.setup({})

nnoremap("<leader>ng", function()
	neogit.open({ kind = "vsplit" })
end)
