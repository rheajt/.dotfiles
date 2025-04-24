-- local home = vim.fn.expand("$HOME")
local defaults = {
	yank_register = "+",
	edit_with_instructions = {
		diff = false,
		keymaps = {
			close = "<C-c>",
			accept = "<C-y>",
			toggle_diff = "<C-d>",
			toggle_settings = "<C-o>",
			cycle_windows = "<Tab>",
			use_output_as_input = "<C-i>",
		},
	},
	chat = {
		welcome_message = "Welcome jojo",
		loading_text = "Loading, please wait ...",
		question_sign = "", -- 🙂
		answer_sign = "ﮧ", -- 🤖
		max_line_length = 120,
		sessions_window = {
			border = {
				-- style = "rounded",
				text = {
					top = " Sessions ",
				},
			},
			win_options = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
		},
		keymaps = {
			close = { "<C-c>" },
			yank_last = "<C-y>",
			yank_last_code = "<C-k>",
			scroll_up = "<C-u>",
			scroll_down = "<C-d>",
			new_session = "<C-n>",
			cycle_windows = "<Tab>",
			cycle_modes = "<C-f>",
			next_message = "<C-j>",
			prev_message = "<C-k>",
			select_session = "<Space>",
			rename_session = "r",
			delete_session = "d",
			draft_message = "<C-d>",
			edit_message = "e",
			delete_message = "d",
			toggle_settings = "<C-o>",
			toggle_message_role = "<C-r>",
			toggle_system_role_open = "<C-s>",
			stop_generating = "<C-x>",
		},
	},
	popup_layout = {
		default = "center",
		center = {
			width = "80%",
			height = "80%",
		},
		right = {
			width = "30%",
			width_settings_open = "50%",
		},
	},
	popup_window = {
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top = " ChatGPT ",
			},
		},
		win_options = {
			wrap = true,
			linebreak = true,
			foldcolumn = "1",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
		buf_options = {
			filetype = "markdown",
		},
	},
	system_window = {
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top = " SYSTEM ",
			},
		},
		win_options = {
			wrap = true,
			linebreak = true,
			foldcolumn = "2",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	popup_input = {
		prompt = "  ",
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top_align = "center",
				top = " Prompt ",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
		submit = "<C-s>",
		submit_n = "<Enter>",
		max_visible_lines = 20,
	},
	settings_window = {
		border = {
			style = "rounded",
			text = {
				top = " Settings ",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
	openai_params = {
		model = "gpt-4-turbo",
		frequency_penalty = 0,
		presence_penalty = 0,
		max_tokens = 4096,
		temperature = 0,
		top_p = 1,
		n = 1,
	},
	openai_edit_params = {
		model = "gpt-4-turbo",
		frequency_penalty = 0,
		presence_penalty = 0,
		temperature = 0,
		top_p = 1,
		n = 1,
	},
	use_openai_functions_for_edits = false,
	actions_paths = {},
	show_quickfixes_cmd = "Trouble quickfix",
	predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
}

function OpenRightPane()
	-- Save the current window number
	local currentWindow = vim.api.nvim_get_current_win()
	-- Open a new vertical split to the right
	vim.cmd("vnew")
	-- Set the width of the new pane to 20 columns
	vim.cmd("vertical resize 20")
	-- Switch to the newly created window
	local newWindow = vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(newWindow)
	-- Switch back to the original window
	-- vim.api.nvim_set_current_win(currentWindow)
end

return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		require("kickstart.deprecated.chatgpt").setup(defaults)
		vim.keymap.set("n", "<leader>tc", ":ChatGPT<cr>", { noremap = true, silent = true, desc = "Open ChatGPT" })
		vim.keymap.set(
			{ "n", "v" },
			"<leader>te",
			"<cmd>ChatGPTEditWithInstruction<CR>",
			{ noremap = true, silent = true, desc = "Edit with ChatGPT" }
		)
		vim.keymap.set(
			"v",
			"<leader>tg",
			"<cmd>ChatGPTRun grammar_correction<CR>",
			{ noremap = true, silent = true, desc = "Run grammar correction" }
		)
		vim.keymap.set(
			"v",
			"<leader>tt",
			"<cmd>ChatGPTRun translate<CR>",
			{ noremap = true, silent = true, desc = "Translate text" }
		)
		vim.keymap.set(
			"v",
			"<leader>tk",
			"<cmd>ChatGPTRun keywords<CR>",
			{ noremap = true, silent = true, desc = "Generate keywords" }
		)
		vim.keymap.set(
			"v",
			"<leader>td",
			"<cmd>ChatGPTRun docstring<CR>",
			{ noremap = true, silent = true, desc = "Generate docstring" }
		)
		vim.keymap.set(
			"v",
			"<leader>ta",
			"<cmd>ChatGPTRun add_tests<CR>",
			{ noremap = true, silent = true, desc = "Add tests" }
		)
		vim.keymap.set(
			"v",
			"<leader>to",
			"<cmd>ChatGPTRun optimize_code<CR>",
			{ noremap = true, silent = true, desc = "Optimize code" }
		)
		vim.keymap.set(
			"v",
			"<leader>ts",
			"<cmd>ChatGPTRun summarize<CR>",
			{ noremap = true, silent = true, desc = "Summarize text" }
		)
		vim.keymap.set(
			"v",
			"<leader>tf",
			"<cmd>ChatGPTRun fix_bugs<CR>",
			{ noremap = true, silent = true, desc = "Fix bugs" }
		)
		vim.keymap.set(
			"v",
			"<leader>tx",
			"<cmd>ChatGPTRun explain_code<CR>",
			{ noremap = true, silent = true, desc = "Explain code" }
		)
		vim.keymap.set(
			{ "n", "v" },
			"<leader>tr",
			"<cmd>ChatGPTRun code_readability_analysis<CR>",
			{ noremap = true, silent = true, desc = "Run code readability analysis" }
		)
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
