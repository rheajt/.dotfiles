return {
	"nvim-telescope/telescope.nvim",
	opts = {},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-x>"] = actions.select_vertical,
					},
					n = {
						["<C-x>"] = actions.select_vertical,
					},
				},
				-- pickers = {
				-- 	find_files = { theme = "ivy" },
				-- 	live_grep = { theme = "ivy" },
				-- 	buffers = { theme = "ivy" },
				-- 	help_tags = { theme = "ivy" },
				-- 	treesitter = { theme = "ivy" },
				-- },
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
				borderchars = {
					prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
					results = { " " },
					preview = { " " },
				},
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
		vim.keymap.set("n", "<leader>ff", function()
			require("telescope.builtin").find_files({ hidden_files = true })
		end)

		vim.keymap.set("n", "<leader>fg", function()
			require("telescope.builtin").live_grep({ hidden_files = true })
		end)

		vim.keymap.set("n", "<leader>fr", function()
			require("telescope.builtin").grep_string({ hidden_files = true })
		end)

		vim.keymap.set("n", "<leader>fb", function()
			require("telescope.builtin").buffers()
		end)

		vim.keymap.set("n", "<leader>fe", function()
			require("telescope").extensions.file_browser.file_browser()
		end)

		vim.keymap.set("n", "<leader>fh", function()
			require("telescope.builtin").help_tags()
		end)

		vim.keymap.set("n", "<leader>fk", function()
			require("telescope.builtin").keymaps()
		end)

		vim.keymap.set("n", "<leader>ft", function()
			require("telescope.builtin").treesitter()
		end)

		vim.keymap.set("n", "<leader>fd", function()
			require("telescope.builtin").diagnostics(require("telescope.themes").get_dropdown({}))
		end)

		vim.keymap.set("n", "<leader>fs", function()
			require("telescope").extensions.npm.scripts(require("telescope.themes").get_dropdown({}))
		end)

		vim.keymap.set("n", "<leader>fp", function()
			require("telescope").extensions.npm.packages(require("telescope.themes").get_dropdown({}))
		end)

		require("telescope").load_extension("fzf")
	end,
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"elianiva/telescope-npm.nvim",
	},
}
