return {
	"terrortylor/nvim-comment",
	config = function()
		vim.keymap.set("n", "<leader>/", ":CommentToggle<CR>")
		vim.keymap.set("v", "<leader>/", ":'<,'>CommentToggle<CR>")

		require("nvim_comment").setup({
			comment_empty = false,
		})
	end,
}
