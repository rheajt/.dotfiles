local configs = require("nvim-treesitter.configs")
local nnoremap = require("config.keymap_binds").nnoremap

nnoremap("<leader>tsp", ":TSPlaygroundToggle<CR>")

configs.setup({
	ensure_installed = "all", -- Only use parsers that are maintained
	ignore_install = { "comment" },
	highlight = {          -- enable highlighting
		enable = true,
	},
	indent = {
		enable = false, -- default is disabled anyways
	},
})
