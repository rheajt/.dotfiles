return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		local home = vim.fn.expand("$HOME")
		require("chatgpt").setup({
			api_key_cmd = "gpg -d " .. home .. "/chatgpt-secret.txt.gpg",
		})
		vim.keymap.set("n", "<leader>gg", ":ChatGPT<cr>", { noremap = true, silent = true })
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
