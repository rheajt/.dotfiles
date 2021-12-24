-- local status_ok, actions = pcall(require, "telescope.actions")
-- if not status_ok then
--   return
-- end
local actions = require("telescope.actions")

require("telescope").setup({
	pickers = {
		find_files = { theme = "ivy" },
		live_grep = { theme = "ivy" },
		buffers = { theme = "ivy" },
		help_tags = { theme = "ivy" },
		treesitter = { theme = "ivy" },
	},
	defaults = {
		mappings = {
			i = {
				["<C-x>"] = actions.select_vertical,
			},
			n = {
				["<C-x>"] = actions.select_vertical,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		path_display = {},
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	},
})

require("telescope").load_extension("fzf")
