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
		{ -- Adds git related signs to the gutter, as well as utilities for managing changes
			"lewis6991/gitsigns.nvim",
			event = "VeryLazy",
			opts = {
				signcolumn = true,
			},
		},
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = "snacks.nvim", words = { "Snacks", "snacks" } },
				},
			},
		},
		{ -- Useful plugin to show you pending keybinds.
			"folke/which-key.nvim",
			event = "VimEnter", -- Sets the loading event to 'VimEnter'
			opts = {
				-- delay between pressing a key and opening which-key (milliseconds)
				-- this setting is independent of vim.opt.timeoutlen
				delay = 0,
				icons = {
					-- set icon mappings to true if you have a Nerd Font
					mappings = vim.g.have_nerd_font,
					-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
					-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
					keys = vim.g.have_nerd_font and {} or {
						Up = "<Up> ",
						Down = "<Down> ",
						Left = "<Left> ",
						Right = "<Right> ",
						C = "<C-…> ",
						M = "<M-…> ",
						D = "<D-…> ",
						S = "<S-…> ",
						CR = "<CR> ",
						Esc = "<Esc> ",
						ScrollWheelDown = "<ScrollWheelDown> ",
						ScrollWheelUp = "<ScrollWheelUp> ",
						NL = "<NL> ",
						BS = "<BS> ",
						Space = "<Space> ",
						Tab = "<Tab> ",
						F1 = "<F1>",
						F2 = "<F2>",
						F3 = "<F3>",
						F4 = "<F4>",
						F5 = "<F5>",
						F6 = "<F6>",
						F7 = "<F7>",
						F8 = "<F8>",
						F9 = "<F9>",
						F10 = "<F10>",
						F11 = "<F11>",
						F12 = "<F12>",
					},
				},
			},
			config = function(_, opts)
				local wk = require("which-key")
				wk.setup(opts)

				wk.add({
					{ "<leader>a", group = "[A]I / Sidekick" },
					{ "<leader>c", group = "[C]lose / Buffers" },
					{ "<leader>d", group = "[D]iagnostics / Quickfix" },
					{ "<leader>h", group = "[H]arpoon" },
					{ "<leader>l", group = "[L]azy / Extras" },
					{ "<leader>q", group = "[Q]uick actions / Terminal" },
					{ "<leader>s", group = "[S]earch / Snacks" },

					{ "<leader>f", desc = "[F]ormat buffer" },
					{ "<leader>cc", desc = "[C]lose [C]urrent Buffer" },
					{ "<leader>qt", desc = "Open [T]erminal" },
					{ "<leader>sns", desc = "[S]plit [N]ew [S]idebar" },

					{ "<leader>dd", desc = "QuickFix: [D]elete current line" },
					{ "<leader>df", desc = "QuickFix: Go to [F]irst" },
					{ "<leader>dl", desc = "QuickFix: Go to [L]ast" },
					{ "<leader>dn", desc = "QuickFix: Go to [N]ext" },
					{ "<leader>dp", desc = "QuickFix: Go to [P]revious" },
					{ "<leader>do", desc = "QuickFix: [O]pen/Close" },

					{ "<leader>sf", desc = "[S]earch for [F]iles" },
					{ "<leader>sb", desc = "[S]earch for [B]uffers" },
					{ "<leader>sd", desc = "[S]earch for [D]iagnostics" },
					{ "<leader>sh", desc = "[S]earch for [H]elp" },
					{ "<leader>sg", desc = "Search for [G]it files" },
					{ "<leader>sk", desc = "[S]earch for [K]eys" },
					{ "<leader>sc", desc = "[S]earch for current [C]word under cursor", mode = { "n", "v" } },
					{ "<leader>se", desc = "[S]earch file [E]xplorer" },

					{ "<leader>lg", desc = "[L]aunch [G]it in Lazygit" },
					{ "<leader>ld", desc = "[L]ook at the current scope by [D]imming the rest" },

					{ "<leader>ha", desc = "Harpoon add file" },
					{ "<leader>hm", desc = "Harpoon menu" },
					{ "<leader>hn", desc = "Harpoon next" },
					{ "<leader>hp", desc = "Harpoon previous" },
					{ "<leader>1", desc = "Harpoon file 1" },
					{ "<leader>2", desc = "Harpoon file 2" },
					{ "<leader>3", desc = "Harpoon file 3" },
					{ "<leader>4", desc = "Harpoon file 4" },

					{ "<leader>aa", desc = "Sidekick Toggle CLI" },
					{ "<leader>as", desc = "Sidekick Select CLI" },
					{ "<leader>ad", desc = "Detach a CLI Session" },
					{ "<leader>at", desc = "Send This", mode = { "n", "x" } },
					{ "<leader>af", desc = "Send File" },
					{ "<leader>av", desc = "Send Visual Selection", mode = { "x" } },
					{ "<leader>ap", desc = "Sidekick Select Prompt", mode = { "n", "x" } },
					{ "<leader>ac", desc = "Sidekick Toggle Opencode" },
				})

				wk.add({
					{ "<leader>p", desc = "[P]aste without yanking" },
				}, { mode = "v" })
			end,
		},
		{ -- Autoformat
			"stevearc/conform.nvim",
			event = "VeryLazy",
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
							indent_width = 4,
						},
					},
					injected = {
						options = {
							ft_parsers = {
								handlebars = "angular",
							},
						},
					},
					-- xmlformatter = {
					-- 	cmd = "xmlformatter",
					-- 	args = { "--indent", "4" },
					-- 	settings = {
					-- 		compress = false,
					-- 	},
					-- },
					prettier = {
						settings = {
							tabWidth = 4,
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
					scss = { "prettierd", "prettier" },
					gql = { "prettierd", "prettier" },
					graphql = { "prettierd", "prettier" },
					sh = { "beautysh" },
					markdown = { "prettierd", "prettier" },
					sql = { "sleek" },
					handlebars = { "prettierd", "prettier" },
					xml = { "lemminx" },
				},
			},
		},

		-- Highlight todo, notes, etc in comments
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				signs = false,
			},
		},

		{ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			event = "VeryLazy",
			build = ":TSUpdate",
			opts = {
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"html",
					"lua",
					"luadoc",
					"markdown",
					"vim",
					"vimdoc",
					"sql",
				},
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
		{ import = "plugins" },
	},
	---@diagnostic disable-next-line: missing-fields
	{
		ui = {
			icons = vim.g.have_nerd_font and {} or {
				cmd = "⌘ ",
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
