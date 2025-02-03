-- delete an item from the quickfix list
local function DeleteCurrentLine()
	-- list the items on the quickfix list
	local qflist = vim.fn.getqflist()

	-- get the current line number in the quickfix list
	local current_idx = vim.fn.getqflist({ idx = 0 }).idx

	-- filter out the current item
	local newlist = vim.tbl_filter(function(idx)
		return idx ~= current_idx
	end, qflist)

	print("current_idx:" .. current_idx)

	-- remove item from the quickfix list
	vim.fn.setqflist(newlist, "r")
end

-- function that toggles the quickfix window open and closed
local function ToggleQuickFix()
	local qf_win = vim.fn.getqflist({ winid = true }).winid
	if qf_win ~= 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

function DeleteOpenFileBuffer()
	-- confirm delete
	local confirm = vim.fn.input("Delete buffer? (y/n): ")
	if confirm ~= "y" then
		return
	end

	local current_file = vim.api.nvim_buf_get_name(0)
	if current_file ~= "" then
		vim.cmd("bdelete!")
		os.remove(current_file)
	else
		print("No file is currently open.")
	end
end

vim.keymap.set("n", "<leader>dd", DeleteCurrentLine, { silent = true, desc = "QuickFix: [D]elete current line" })
vim.keymap.set("n", "<leader>df", ":cfirst<CR>zz", { silent = true, desc = "QuickFix: Go to [F]irst" })
vim.keymap.set("n", "<leader>dl", ":clast<CR>zz", { silent = true, desc = "QuickFix: Go to [L]ast" })
vim.keymap.set("n", "<leader>dn", ":cnext<CR>zz", { silent = true, desc = "QuickFix: Go to [N]ext" })
vim.keymap.set("n", "<leader>dp", ":cprev<CR>zz", { silent = true, desc = "QuickFix: Go to [P]revious" })
vim.keymap.set("n", "<leader>do", ToggleQuickFix, { silent = true, desc = "QuickFix: [O]pen/Close" })

print("Quickfix mods loaded")
