local function make_notes()
	print("Making notes...")
end

vim.keymap.set("n", "<leader>mn", function()
	make_notes()
end, { silent = true, desc = "[M]ake [N]otes" })
