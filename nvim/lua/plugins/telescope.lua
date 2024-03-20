return {
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local lga_actions = require("telescope-live-grep-args.actions")

			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
					file_browser = {
						-- theme = "cursor",
						grouped = true,
						path = vim.fn.expand("%:p"),
						select_buffer = true,
						hijack_netrw = true,
					},
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
					sorting_strategy = "ascending",
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
						prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
						results = { " " },
						preview = { " " },
					},
					color_devicons = true,
					use_less = true,
					path_display = {},
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")

			vim.keymap.set("n", "<leader>ff", function()
				require("telescope.builtin").find_files({ hidden_files = true })
			end)

			-- vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
			vim.keymap.set("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args)

			local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
			vim.keymap.set("n", "<leader>fc", live_grep_args_shortcuts.grep_word_under_cursor)
			vim.keymap.set("x", "<leader>fv", live_grep_args_shortcuts.grep_visual_selection)

			vim.keymap.set("n", "<leader>fr", function()
				require("telescope.builtin").grep_string({ hidden_files = true })
			end)

			vim.keymap.set("n", "<leader>fb", function()
				require("telescope.builtin").buffers()
			end)

			vim.keymap.set("n", "<leader>e", function()
				-- path=%:p:h select_buffer=true<CR>
				require("telescope").extensions.file_browser.file_browser({
					path = vim.fn.expand("%:p:h"),
					select_buffer = true,
				})
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
		end,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"elianiva/telescope-npm.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
}
