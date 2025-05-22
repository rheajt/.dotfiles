return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		-- Set the highlight group for nvim-treesitter-context
		-- hi TreesitterContextBottom gui=underline guisp=Grey
		-- hi TreesitterContextLineNumberBottom gui=underline guisp=Grey
		vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
		vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = true, sp = "Grey" })
	end,
}
