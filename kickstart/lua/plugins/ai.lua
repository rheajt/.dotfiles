-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local prompts = {
	grammar = {
		description = "Correct grammar",
		prompt = "Correct the @buffer to standard English, but keep any code blocks inside intact.",
	},
	extract_keywords = {
		description = "Extract keywords",
		prompt = "Extract the main keywords from the @buffer",
	},
	readability = {
		description = "Code readability analysis",
		prompt = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]],
	},
	optimize = {
		description = "Optimize code",
		prompt = "Optimize the code in this @buffer in a few sentences",
	},
	summarize_selection = {
		description = "Summarize selection",
		prompt = "Summarize the @selection in a few sentences",
	},
	translate = {
		description = "Translate to Chinese",
		prompt = "Translate this into Chinese, but keep any code blocks inside intact",
	},
	explain = {
		description = "Explain code",
		prompt = "Explain the code in this @buffer",
	},
	complete = {
		description = "Complete code",
		prompt = "Complete the @selection written in " .. vim.bo.filetype,
	},
	docstring = {
		description = "Add docstrings",
		prompt = "Add docstrings to the @buffer",
	},
	fix_bugs = {
		description = "Fix bugs",
		prompt = "Fix the bugs inside the @buffer, if any",
	},
	tests = {
		description = "Add tests",
		prompt = "Implement tests for the current @buffer",
	},
}
return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = { "folke/snacks.nvim" },
		---@type opencode.Config
		opts = {
			auto_fallback_to_embedded = false,
		},
		config = function()
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`
			}

			-- Required for `opts.auto_reload`
			vim.opt.autoread = true

			-- Recommended keymaps
			vim.keymap.set("n", "<leader>ot", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })
			vim.keymap.set("n", "<leader>oA", function()
				require("opencode").ask()
			end, { desc = "Ask opencode" })
			vim.keymap.set("n", "<leader>oa", function()
				require("opencode").ask("@cursor: ")
			end, { desc = "Ask opencode about this" })
			vim.keymap.set("v", "<leader>oa", function()
				require("opencode").ask("@selection: ")
			end, { desc = "Ask opencode about selection" })
			vim.keymap.set("n", "<leader>on", function()
				require("opencode").command("session_new")
			end, { desc = "New opencode session" })
			vim.keymap.set("n", "<leader>oy", function()
				require("opencode").command("messages_copy")
			end, { desc = "Copy last opencode response" })
			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("messages_half_page_up")
			end, { desc = "Messages half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("messages_half_page_down")
			end, { desc = "Messages half page down" })
			vim.keymap.set({ "n", "v" }, "<leader>os", function()
				require("opencode").select()
			end, { desc = "Select opencode prompt" })

			-- Keymaps for predefined prompts
			for _, prompt in pairs(prompts) do
				print(prompt.description)
				vim.keymap.set({ "n", "v" }, "<leader>oc" .. prompt.prompt:sub(1, 1):lower(), function()
					require("opencode").prompt(prompt.prompt)
				end, { desc = prompt.description })
			end
			-- Example: keymap for custom prompt
			-- vim.keymap.set("n", "<leader>oe", function()
			-- 	require("opencode").prompt("Explain @cursor and its context")
			-- end, { desc = "Explain this code" })
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		enabled = true,
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				filetypes = {
					norg = false,
					["snacks.picker"] = false,
				},
				suggestion = { enabled = true, auto_trigger = true },
				-- panel = { enabled = false },
			})

			vim.keymap.set("i", "<right>", function()
				require("copilot.suggestion").accept()
			end, { desc = "Accept Copilot suggestion" })
			vim.keymap.set("i", "<up>", function()
				require("copilot.suggestion").next()
			end, { desc = "Next Copilot Suggestion" })
			vim.keymap.set("i", "<down>", function()
				require("copilot.suggestion").prev()
			end, { desc = "Prev Copilot Suggestion" })
		end,
	},
}
