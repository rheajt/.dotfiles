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

vim.pack.add({
	"https://github.com/folke/sidekick.nvim",
	"https://github.com/zbirenbaum/copilot.lua",
})

require("copilot").setup({
	filetypes = {
		norg = false,
		["snacks.picker"] = false,
	},
	suggestion = { enabled = true, auto_trigger = true },
	-- panel = { enabled = false },
})

require("sidekick").setup({
	-- add any options here
	cli = {
		mux = {
			backend = "tmux",
			enabled = true,
		},
		prompts = prompts,
	},
})

vim.keymap.set("n", "<tab>", function()
	-- if there is a next edit, jump to it, otherwise apply it if any
	if not require("sidekick").nes_jump_or_apply() then
		return "<Tab>" -- fallback to normal tab
	end
end, { desc = "Goto/Apply Next Edit Suggestion" })
vim.keymap.set("n", "<c-.>", function()
	require("sidekick.cli").toggle()
end, { desc = "Sidekick Toggle" })
vim.keymap.set("n", "<leader>aa", function()
	require("sidekick.cli").toggle()
end, { desc = "Sidekick Toggle CLI" })
vim.keymap.set(
	"n",
	"<leader>as",
	function()
		require("sidekick.cli").select()
	end,
	-- Or to select only installed tools:
	-- require("sidekick.cli").select({ filter = { installed = true } })
	{ desc = "Select CLI" }
)
vim.keymap.set("n", "<leader>ad", function()
	require("sidekick.cli").close()
end, { desc = "Detach a CLI Session" })
vim.keymap.set({ "x", "n" }, "<leader>at", function()
	require("sidekick.cli").send({ msg = "{this}" })
end, { desc = "Send This" })
vim.keymap.set("n", "<leader>af", function()
	require("sidekick.cli").send({ msg = "{file}" })
end, { desc = "Send File" })
vim.keymap.set("x", "<leader>av", function()
	require("sidekick.cli").send({ msg = "{selection}" })
end, { desc = "Send Visual Selection" })
vim.keymap.set({ "x", "n" }, "<leader>ap", function()
	local opts = {
		prompts = { hello = "world" },
	}
	require("sidekick.cli").prompt(opts)
end, { desc = "Sidekick Select Prompt" })
-- Example of a keybinding to open Claude directly
vim.keymap.set("n", "<leader>ac", function()
	require("sidekick.cli").toggle({ name = "opencode", focus = true })
end, { desc = "Sidekick Toggle Opencode" })

vim.keymap.set("i", "<right>", function()
	require("copilot.suggestion").accept()
end, { desc = "Accept Copilot suggestion" })
vim.keymap.set("i", "<up>", function()
	require("copilot.suggestion").next()
end, { desc = "Next Copilot Suggestion" })
vim.keymap.set("i", "<down>", function()
	require("copilot.suggestion").prev()
end, { desc = "Prev Copilot Suggestion" })
