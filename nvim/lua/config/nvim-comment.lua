local nnoremap = require("config.keymap_binds").nnoremap
local vnoremap = require("config.keymap_binds").vnoremap

-- NVIM COMMENT
nnoremap("<leader>/", ":CommentToggle<CR>")
vnoremap("<leader>/", ":'<,'>CommentToggle<CR>")

require("nvim_comment").setup({
	comment_empty = false,
})
