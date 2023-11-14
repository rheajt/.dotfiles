return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = "all", -- Only use parsers that are maintained
			ignore_install = { "comment" },
			highlight = {    -- enable highlighting
				enable = true,
			},
			indent = {
				enable = false, -- default is disabled anyways
			},
		})
	end,
}
