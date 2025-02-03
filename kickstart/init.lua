vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Install `lazy.nvim` plugin manager ]] See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup(
	{
		{ "numToStr/Comment.nvim", opts = {} },
		{ -- Adds git related signs to the gutter, as well as utilities for managing changes
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			},
		},
		{ -- Useful plugin to show you pending keybinds.
			"folke/which-key.nvim",
			event = "VimEnter", -- Sets the loading event to 'VimEnter'
			opts = {},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		-- {
		-- 	"nvim-telescope/telescope.nvim",
		-- 	event = "VimEnter",
		-- 	branch = "0.1.x",
		-- 	dependencies = {
		-- 		"nvim-lua/plenary.nvim",
		-- 		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
		-- 			"nvim-telescope/telescope-fzf-native.nvim",
		-- 			build = "make",
		-- 			cond = function()
		-- 				return vim.fn.executable("make") == 1
		-- 			end,
		-- 		},
		-- 		{ "nvim-telescope/telescope-ui-select.nvim" },
		-- 		{ "nvim-telescope/telescope-file-browser.nvim" },
		-- 		{ "elianiva/telescope-npm.nvim" },
		-- 		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		-- 	},
		-- 	config = function()
		-- 		require("telescope").setup({
		-- 			defaults = {
		-- 				mappings = {
		-- 					i = { ["<c-enter>"] = "to_fuzzy_refine" },
		-- 				},
		-- 			},
		-- 			pickers = {},
		-- 			extensions = {
		-- 				["ui-select"] = {
		-- 					require("telescope.themes").get_dropdown(),
		-- 				},
		-- 				file_browser = {
		-- 					grouped = true,
		-- 				},
		-- 			},
		-- 		})
		-- 		pcall(require("telescope").load_extension, "fzf")
		-- 		pcall(require("telescope").load_extension, "ui-select")
		-- 		pcall(require("telescope").load_extension, "file_browser")
		-- 		pcall(require("telescope").load_extension, "npm")
		--
		-- 		local builtin = require("telescope.builtin")
		-- 		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		-- 		vim.keymap.set("n", "<leader>se", function()
		-- 			require("telescope").extensions.file_browser.file_browser({
		-- 				path = vim.fn.expand("%:p:h"),
		-- 				select_buffer = true,
		-- 			})
		-- 		end, { desc = "[S]earch Dir[E]ctory" })
		-- 		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		-- 		vim.keymap.set("n", "<leader>sf", function()
		-- 			builtin.find_files({ hidden = true })
		-- 		end, { desc = "[S]earch [F]iles" })
		-- 		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		-- 		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		-- 		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		-- 		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		-- 		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch open [B]uffers" })
		-- 		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		-- 		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		-- 		vim.keymap.set("n", "<leader>st", ":TodoTelescope<cr>", { desc = "[S]earch [T]odo items" })
		--
		-- 		vim.keymap.set("n", "<leader>sns", function()
		-- 			require("telescope").extensions.npm.scripts(require("telescope.themes").get_dropdown({}))
		-- 		end, { desc = "[S]earch [N]pm [S]cripts" })
		-- 		vim.keymap.set("n", "<leader>snp", function()
		-- 			require("telescope").extensions.npm.packages(require("telescope.themes").get_dropdown({}))
		-- 		end, { desc = "[S]earch [N]pm [P]ackages" })
		--
		-- 		vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" })
		-- 		vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"gI",
		-- 			require("telescope.builtin").lsp_implementations,
		-- 			{ desc = "[G]oto [I]mplementation" }
		-- 		)
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<leader>D",
		-- 			require("telescope.builtin").lsp_type_definitions,
		-- 			{ desc = "Type [D]efinition" }
		-- 		)
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<leader>ds",
		-- 			require("telescope.builtin").lsp_document_symbols,
		-- 			{ desc = "[D]ocument [S]ymbols" }
		-- 		)
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<leader>ws",
		-- 			require("telescope.builtin").lsp_dynamic_workspace_symbols,
		-- 			{ desc = "[W]orkspace [S]ymbols" }
		-- 		)
		--
		-- 		-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		--
		-- 		-- Slightly advanced example of overriding default behavior and theme
		-- 		vim.keymap.set("n", "<leader>/", function()
		-- 			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
		-- 			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		-- 				winblend = 10,
		-- 				previewer = false,
		-- 			}))
		-- 		end, { desc = "[/] Fuzzily search in current buffer" })
		--
		-- 		-- It's also possible to pass additional configuration options.
		-- 		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		-- 		vim.keymap.set("n", "<leader>s/", function()
		-- 			builtin.live_grep({
		-- 				grep_open_files = true,
		-- 				prompt_title = "Live Grep in Open Files",
		-- 			})
		-- 		end, { desc = "[S]earch [/] in Open Files" })
		--
		-- 		-- Shortcut for searching your Neovim configuration files
		-- 		vim.keymap.set("n", "<leader>sn", function()
		-- 			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		-- 		end, { desc = "[S]earch [N]eovim files" })
		-- 	end,
		-- },

		{ -- Autoformat
			"stevearc/conform.nvim",
			lazy = false,
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_fallback = true })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				formatters = {
					stylua = {
						opts = {
							indent_type = "Spaces",
						},
					},
					injected = {
						options = {
							ft_parsers = {
								handlebars = "angular",
							},
						},
					},
				},
				notify_on_error = true,
				format_on_save = function(bufnr)
					local disable_filetypes = { c = true, cpp = true }
					return {
						timeout_ms = 500,
						lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
					}
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					typescript = { "prettierd", "prettier" },
					javascript = { "prettierd", "prettier" },
					typescriptreact = { "prettierd", "prettier" },
					javascriptreact = { "prettierd", "prettier" },
					json = { "prettierd", "prettier" },
					html = { "prettierd", "prettier" },
					css = { "prettierd", "prettier" },
					sh = { "beautysh" },
					markdown = { "prettierd", "prettier" },
					sql = { "sqlfmt" },
					handlebars = { "prettierd", "prettier" },
					xml = { "xmlformatter" },
				},
			},
		},

		-- Highlight todo, notes, etc in comments
		{
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = true },
			keys = {
				{
					"<leader>st",
					function()
						Snacks.picker.todo_comments()
					end,
					desc = "Todo",
				},
			},
		},

		{ -- Collection of various small independent plugins/modules
			"echasnovski/mini.nvim",
			config = function()
				-- Better Around/Inside textobjects
				--
				-- Examples:
				--  - va)  - [V]isually select [A]round [)]paren
				--  - yinq - [Y]ank [I]nside [N]ext [']quote
				--  - ci'  - [C]hange [I]nside [']quote
				require("mini.ai").setup({ n_lines = 500 })

				-- Add/delete/replace surroundings (brackets, quotes, etc.)
				--
				-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				-- - sd'   - [S]urround [D]elete [']quotes
				-- - sr)'  - [S]urround [R]eplace [)] [']
				require("mini.surround").setup()
			end,
		},
		{ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			opts = {
				ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "ruby" },
				},
				indent = { enable = true, disable = { "ruby" } },
			},
			config = function(_, opts)
				require("nvim-treesitter.install").prefer_git = true
				---@diagnostic disable-next-line: missing-fields
				require("nvim-treesitter.configs").setup(opts)
			end,
		},
		{ import = "custom.plugins" },
	},
	---@diagnostic disable-next-line: missing-fields
	{
		ui = {
			icons = vim.g.have_nerd_font and {} or {
				cmd = "⌘",
				config = "🛠",
				event = "📅",
				ft = "📂",
				init = "⚙",
				keys = "🗝",
				plugin = "🔌",
				runtime = "💻",
				require = "🌙",
				source = "📄",
				start = "🚀",
				task = "📌",
				lazy = "💤 ",
			},
		},
	}
)
