-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local custom_prompts = {
	grammar = {
		description = "Correct grammar",
		prompt = "Correct the {buffer} to standard English, but keep any code blocks inside intact.",
	},
	extract_keywords_buffer = {
		description = "Extract keywords",
		prompt = "Extract the main keywords from the {buffer}",
	},
	readability_selection = {
		description = "Code readability analysis",
		prompt = [[
          You must identify any readability issues in the {selection}
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
	optimize_buffer = {
		description = "Optimize code",
		prompt = "Optimize the code in this {buffer} in a few sentences",
	},
	summarize_selection = {
		description = "Summarize selection",
		prompt = "Summarize the {selection} in a few sentences",
	},
	translate = {
		description = "Translate to Chinese",
		prompt = "Translate {selection} into Chinese, but keep any code blocks inside intact",
	},
	explain = {
		description = "Explain code",
		prompt = "Explain the code in this {buffer}",
	},
	complete = {
		description = "Complete code",
		prompt = "Complete the {selection} written in " .. vim.bo.filetype,
	},
	docstring = {
		description = "Add docstrings",
		prompt = "Add docstrings to the {buffer}",
	},
	fix_bugs = {
		description = "Fix bugs",
		prompt = "Fix the bugs inside the {buffer}, if any",
	},
	tests = {
		description = "Add tests",
		prompt = "Implement tests for the current {buffer}",
	},
	refactor = {
		description = "Refactor the buffer",
		prompt = "Refactor the code in the current {buffer}",
	},
}

local prompts = {}
for key, value in pairs(custom_prompts) do
	prompts[key] = value.prompt
end

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
				prompts = prompts,
			},
		},
		keys = {
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if require("sidekick").nes_jump_or_apply() then
						return -- jumped or applied
					end

					-- if you are using Neovim's native inline completions
					if
						vim.fn.has("nvim-0.10") == 1
						and vim.lsp.inline_completion
						and vim.lsp.inline_completion.get()
					then
						return
					end

					-- any other things (like snippets) you want to do on <tab> go here.
					if vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
						return
					end

					-- fall back to normal tab
					return "<tab>"
				end,
				mode = { "i", "s" },
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if require("sidekick").nes_jump_or_apply() then
						return -- jumped or applied
					end

					-- if you are using Neovim's native inline completions
					if
						vim.fn.has("nvim-0.10") == 1
						and vim.lsp.inline_completion
						and vim.lsp.inline_completion.get()
					then
						return
					end

					-- any other things (like snippets) you want to do on <tab> go here.
					-- TODO: fix this for luasnip completions
					-- vim.snippet.expand_or_jumpable()

					-- fall back to normal tab
					return "<tab>"
				end,
				mode = { "n" },
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
					local opts = {
						prompts = { hello = "world" },
					}
					require("sidekick.cli").prompt(opts)
				end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
			-- Example of a keybinding to open Claude directly
			{
				"<leader>ac",
				function()
					require("sidekick.cli").toggle({ name = "opencode", focus = true })
				end,
				desc = "Sidekick Toggle Opencode",
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
