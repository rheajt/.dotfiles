return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		filetypes = {
			neorg = false,
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
		},
	},
}
