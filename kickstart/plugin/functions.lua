function OpenTmuxSidebar()
	-- check if there is a package.json file in the project root
	local packageJson = io.open("package.json", "r")
	if packageJson == nil then
		print("No package.json file found")
		return
	end

	Snacks.input("Enter a command", function(input)
		print("input: " .. input)
		os.execute("tmux split-window -h")
		os.execute("tmux send-keys -t right 'npm run " .. input .. "' C-m")
	end)
	-- Open a new tmux window on the right side
	-- os.execute("tmux split-window -h")

	-- Run a command in the new tmux window
	-- os.execute("tmux send-keys -t right '~/projects/dotfiles/bash-scripts/package-scripts' C-m")
end

vim.keymap.set("n", "<leader>sns", function()
	OpenTmuxSidebar()
end, { silent = true, desc = "[S]plit [N]ew [S]idebar" })

print("loaded functions")
