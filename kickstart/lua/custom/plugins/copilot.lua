return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		enabled = true,
		event = "InsertEnter",
		opts = {
			filetypes = {
				neorg = false,
			},
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
}
