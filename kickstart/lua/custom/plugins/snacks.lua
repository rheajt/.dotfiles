---INFO: Snacks.picker
---@class snacks.picker.Config
local picker = {
	prompt = " ",
	sources = {},
	focus = "input",
	layout = {
		cycle = true,
		--- Use the default layout or vertical if the window is too narrow
		preset = function()
			return vim.o.columns >= 120 and "default" or "vertical"
		end,
	},
	---@class snacks.picker.matcher.Config
	matcher = {
		fuzzy = true, -- use fuzzy matching
		smartcase = true, -- use smartcase
		ignorecase = true, -- use ignorecase
		sort_empty = false, -- sort results when the search string is empty
		filename_bonus = true, -- give bonus for matching file names (last part of the path)
		file_pos = true, -- support patterns like `file:line:col` and `file:line`
		-- the bonusses below, possibly require string concatenation and path normalization,
		-- so this can have a performance impact for large lists and increase memory usage
		cwd_bonus = false, -- give bonus for matching files in the cwd
		frecency = false, -- frecency bonus
	},
	sort = {
		-- default sort is by score, text length and index
		fields = { "score:desc", "#text", "idx" },
	},
	ui_select = true, -- replace `vim.ui.select` with the snacks picker
	---@class snacks.picker.formatters.Config
	formatters = {
		text = {
			ft = nil, ---@type string? filetype for highlighting
		},
		file = {
			filename_first = false, -- display filename before the file path
			truncate = 40, -- truncate the file path to (roughly) this length
			filename_only = false, -- only show the filename
		},
		selected = {
			show_always = false, -- only show the selected column when there are multiple selections
			unselected = true, -- use the unselected icon for unselected items
		},
		severity = {
			icons = true, -- show severity icons
			level = false, -- show severity level
		},
	},
	---@class snacks.picker.previewers.Config
	previewers = {
		git = {
			native = false, -- use native (terminal) or Neovim for previewing git diffs and commits
		},
		file = {
			max_size = 1024 * 1024, -- 1MB
			max_line_length = 500, -- max line length
			ft = nil, ---@type string? filetype for highlighting. Use `nil` for auto detect
		},
		man_pager = nil, ---@type string? MANPAGER env to use for `man` preview
	},
	---@class snacks.picker.jump.Config
	jump = {
		jumplist = true, -- save the current position in the jumplist
		tagstack = false, -- save the current position in the tagstack
		reuse_win = false, -- reuse an existing window if the buffer is already open
		close = true, -- close the picker when jumping/editing to a location (defaults to true)
		match = false, -- jump to the first match position. (useful for `lines`)
	},
	toggles = {
		follow = "f",
		hidden = "h",
		ignored = "i",
		modified = "m",
		regex = { icon = "R", value = false },
	},
	win = {
		-- input window
		input = {
			keys = {
				-- to close the picker on ESC instead of going to normal mode,
				-- add the following keymap to your config
				["<Esc>"] = { "close", mode = { "n", "i" } },
				["/"] = "toggle_focus",
				["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
				["<C-Up>"] = { "history_back", mode = { "i", "n" } },
				["<C-c>"] = { "close", mode = "i" },
				["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
				["<CR>"] = { "confirm", mode = { "n", "i" } },
				["<Down>"] = { "list_down", mode = { "i", "n" } },
				["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
				["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
				["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
				["<Up>"] = { "list_up", mode = { "i", "n" } },
				["<a-d>"] = { "inspect", mode = { "n", "i" } },
				["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
				["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
				["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
				["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
				["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
				["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
				["<c-a>"] = { "select_all", mode = { "n", "i" } },
				["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
				["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
				["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
				["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
				-- ["<c-j>"] = { "list_down", mode = { "i", "n" } },
				["<c-k>"] = { "list_up", mode = { "i", "n" } },
				["<c-n>"] = { "list_down", mode = { "i", "n" } },
				["<c-p>"] = { "list_up", mode = { "i", "n" } },
				["<c-q>"] = { "qflist", mode = { "i", "n" } },
				["<c-s>"] = { "edit_split", mode = { "i", "n" } },
				["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
				["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
				["?"] = "toggle_help_input",
				["G"] = "list_bottom",
				["gg"] = "list_top",
				["j"] = "list_down",
				["k"] = "list_up",
				["q"] = "close",
			},
			b = {
				minipairs_disable = true,
			},
		},
		-- result list window
		list = {
			keys = {
				["/"] = "toggle_focus",
				["<2-LeftMouse>"] = "confirm",
				["<CR>"] = "confirm",
				["<Down>"] = "list_down",
				["<Esc>"] = "close",
				["<S-CR>"] = { { "pick_win", "jump" } },
				["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
				["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
				["<Up>"] = "list_up",
				["<a-d>"] = "inspect",
				["<a-f>"] = "toggle_follow",
				["<a-h>"] = "toggle_hidden",
				["<a-i>"] = "toggle_ignored",
				["<a-m>"] = "toggle_maximize",
				["<a-p>"] = "toggle_preview",
				["<a-w>"] = "cycle_win",
				["<c-a>"] = "select_all",
				["<c-b>"] = "preview_scroll_up",
				["<c-d>"] = "list_scroll_down",
				["<c-f>"] = "preview_scroll_down",
				-- ["<c-j>"] = "list_down",
				["<c-k>"] = "list_up",
				["<c-n>"] = "list_down",
				["<c-p>"] = "list_up",
				["<c-s>"] = "edit_split",
				["<c-u>"] = "list_scroll_up",
				["<c-v>"] = "edit_vsplit",
				["?"] = "toggle_help_list",
				["G"] = "list_bottom",
				["gg"] = "list_top",
				["i"] = "focus_input",
				["j"] = "list_down",
				["k"] = "list_up",
				["q"] = "close",
				["zb"] = "list_scroll_bottom",
				["zt"] = "list_scroll_top",
				["zz"] = "list_scroll_center",
			},
			wo = {
				conceallevel = 2,
				concealcursor = "nvc",
			},
		},
		-- preview window
		preview = {
			keys = {
				["<Esc>"] = "close",
				["q"] = "close",
				["i"] = "focus_input",
				["<ScrollWheelDown>"] = "list_scroll_wheel_down",
				["<ScrollWheelUp>"] = "list_scroll_wheel_up",
				["<a-w>"] = "cycle_win",
			},
		},
	},
	---@class snacks.picker.debug
	debug = {
		scores = false, -- show scores in the list
		leaks = false, -- show when pickers don't get garbage collected
	},
}

---@class snacks.lazygit.Config
local lazygit = {
	-- automatically configure lazygit to use the current colorscheme
	-- and integrate edit with the current neovim instance
	configure = true,
	-- extra configuration for lazygit that will be merged with the default
	-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
	-- you need to double quote it: `"\"test\""`
	config = {
		os = { editPreset = "nvim-remote" },
		gui = {
			-- set to an empty string "" to disable icons
			nerdFontsVersion = "3",
		},
	},
	theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
	-- Theme for lazygit
	theme = {
		[241] = { fg = "Special" },
		activeBorderColor = { fg = "MatchParen", bold = true },
		cherryPickedCommitBgColor = { fg = "Identifier" },
		cherryPickedCommitFgColor = { fg = "Function" },
		defaultFgColor = { fg = "Normal" },
		inactiveBorderColor = { fg = "FloatBorder" },
		optionsTextColor = { fg = "Function" },
		searchingActiveBorderColor = { fg = "MatchParen", bold = true },
		selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
		unstagedChangesColor = { fg = "DiagnosticError" },
	},
	win = {
		style = "lazygit",
	},
}
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		dim = { enabled = true },
		explorer = { enabled = true, replace_netrw = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = lazygit,
		notifier = { enabled = true },
		picker = picker,
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			{ desc = "Search for [F]iles" },
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			{ desc = "Search for [B]uffers" },
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			{ desc = "Search for [H]elp" },
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep({
					follow = true,
					hidden = true,
				})
			end,
			{ desc = "Search for [G]it files" },
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			{ desc = "[S]earch for [K]eys" },
		},
		{
			"<leader>se",
			function()
				Snacks.picker.explorer({
					follow_file = true,
					auto_close = true,
				})
			end,
			{ desc = "[S]earch file [E]xplorer" },
		},
		{
			"<leader>ld",
			function()
				Snacks.dim()
			end,
			{ desc = "[L]ook at the current scope by [D]imming the rest" },
		},
	},
}
