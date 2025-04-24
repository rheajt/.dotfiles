return {
	{
		"luisiacc/gruvbox-baby",
		priority = 1000,
		init = function()
			vim.g.gruvbox_baby_keyword_style = "italic"
			vim.g.gruvbox_baby_telescope_theme = 1
			vim.g.gruvbox_baby_background_color = "dark"
			vim.g.gruvbox_baby_function_style = "NONE"
			vim.g.gruvbox_baby_transparent_mode = 1

			vim.cmd.colorscheme("gruvbox-baby")
			-- vim.api.nvim_set_hl(0, "Normal", {
			-- 	bg = "none",
			-- })
			--
			-- vim.api.nvim_set_hl(0, "NonText", {
			-- 	bg = "none",
			-- })
		end,
	},
}
