return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		print("copilot loaded")
		require("copilot").setup({
			filetypes = {
				neorg = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<Right>",
					accept_word = false,
					accept_line = false,
					next = "<C-n>",
					prev = "<C-p>",
					dismiss = "<C-c>",
				},
			},
		})
	end,
}
