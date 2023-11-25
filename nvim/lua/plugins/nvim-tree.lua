-- Tree
return {
	"nvim-tree/nvim-tree.lua",
	enabled = false,
	config = function()
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
		require("nvim-tree").setup({
			renderer = {
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
						folder = {
							arrow_open = "",
							arrow_closed = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
					},
				},
			},
			disable_netrw = true,
			hijack_netrw = true,
			open_on_tab = false,
			hijack_cursor = false,
			update_cwd = false,
			diagnostics = {
				enable = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
				ignore_list = {},
			},
			system_open = {
				cmd = nil,
				args = {},
			},
			filters = {
				dotfiles = false,
				custom = {},
			},
			view = {
				width = 30,
				side = "left",
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
		})
	end,
}
