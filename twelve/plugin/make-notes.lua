local function get_project_name()
	local cwd = vim.fn.getcwd()
	local package_json = cwd .. "/package.json"

	if vim.fn.filereadable(package_json) == 1 then
		local lines = vim.fn.readfile(package_json)
		local ok, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))

		if ok and type(decoded) == "table" and type(decoded.name) == "string" then
			return decoded.name
		end
	end

	return vim.fn.fnamemodify(cwd, ":t")
end

local function make_notes()
	local project_name = get_project_name()
	local timestamp = os.date("%Y-%m-%d")
	local today_notes = vim.fn.expand("~/notes/" .. timestamp .. ".md")
	local header = "# " .. project_name
	local note = vim.fn.input("Note: ")

	if note ~= "" then
		local content = "- [ ] " .. note
		local lines = {}

		if vim.fn.filereadable(today_notes) == 1 then
			lines = vim.fn.readfile(today_notes)
		end

		local header_index

		for index, line in ipairs(lines) do
			if line == header then
				header_index = index
				break
			end
		end

		if header_index then
			table.insert(lines, header_index + 1, content)
		else
			if #lines > 0 and lines[#lines] ~= "" then
				table.insert(lines, "")
			end

			table.insert(lines, header)
			table.insert(lines, content)
		end

		vim.fn.writefile(lines, today_notes)

		print("Note added to " .. today_notes)
	else
		print("No note entered.")
	end
end
local function open_today()
	local timestamp = os.date("%Y-%m-%d")
	local notes_daily_dir = "~/notes/01_journal/"
	local today_notes = vim.fn.expand(notes_daily_dir .. timestamp .. ".md")

	if vim.fn.filereadable(today_notes) == 1 then
		-- open the today_notes in a vertical sidebar of 30% width
		-- only do the vsplit if no buffer opened yet, otherwise just open the file in the current buffer
		if vim.fn.bufnr() == -1 then
			vim.cmd("vsplit " .. today_notes)
			vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.3))
		else
			vim.cmd("edit " .. today_notes)
		end
	else
		-- make the file if it doesn't exist and open it
		-- ensure obsidian is loaded then run
		vim.cmd("Obsidian today")
	end
end

local function open_project()
	local project_name = get_project_name()
	local project_notes = vim.fn.expand("~/notes/02_projects/" .. project_name .. ".md")

	print("Looking for project notes at: " .. project_notes)
	if vim.fn.filereadable(project_notes) == 1 then
		vim.cmd("vsplit " .. project_notes)
		vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.3))
	else
		print("No notes for this project.")
	end
end

-- vim.keymap.set("n", "<leader>mt", function()
--     print("make today")
-- end, { silent = true, desc = "[M]ake [T]oday's notes" })
vim.keymap.set("n", "<leader>mn", make_notes, { silent = true, desc = "[M]ake [N]otes" })
vim.keymap.set("n", "<leader>mo", open_today, { silent = true, desc = "[M]ake [O]pen today's notes" })
vim.keymap.set("n", "<leader>ms", open_project, { silent = true, desc = "[M]ake [P]roject notes" })
vim.keymap.set("n", "<leader>md", function()
	print("day over")
end, { silent = true, desc = "[M]ake [D]ay over" })
