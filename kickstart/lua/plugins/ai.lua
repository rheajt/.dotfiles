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
		"folke/sidekick.nvim",
		opts = {
			-- add any options here
			cli = {
				mux = {
					backend = "tmux",
					enabled = true,
				},
			},
		},
		keys = {
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if not require("sidekick").nes_jump_or_apply() then
						return "<Tab>" -- fallback to normal tab
					end
				end,
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-.>",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>aa",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle CLI",
			},
			{
				"<leader>as",
				function()
					require("sidekick.cli").select()
				end,
				-- Or to select only installed tools:
				-- require("sidekick.cli").select({ filter = { installed = true } })
				desc = "Select CLI",
			},
			{
				"<leader>ad",
				function()
					require("sidekick.cli").close()
				end,
				desc = "Detach a CLI Session",
			},
			{
				"<leader>at",
				function()
					require("sidekick.cli").send({ msg = "{this}" })
				end,
				mode = { "x", "n" },
				desc = "Send This",
			},
			{
				"<leader>af",
				function()
					require("sidekick.cli").send({ msg = "{file}" })
				end,
				desc = "Send File",
			},
			{
				"<leader>av",
				function()
					require("sidekick.cli").send({ msg = "{selection}" })
				end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>ap",
				function()
					require("sidekick.cli").prompt()
				end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
			-- Example of a keybinding to open Claude directly
			{
				"<leader>ac",
				function()
					require("sidekick.cli").toggle({ name = "claude", focus = true })
				end,
				desc = "Sidekick Toggle Claude",
			},
		},
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
