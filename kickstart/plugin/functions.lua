function OpenTmuxSidebar()
	-- Open a new tmux window on the right side
	os.execute("tmux split-window -h")

	-- Run a command in the new tmux window
	os.execute("tmux send-keys -t right '~/projects/dotfiles/bash-scripts/package-scripts' C-m")
end

vim.keymap.set("n", "<leader>sns", function()
	OpenTmuxSidebar()
end, { silent = true, desc = "[S]plit [N]ew [S]idebar" })

print("loaded functions")
