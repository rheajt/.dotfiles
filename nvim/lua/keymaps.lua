local keymap = vim.keymap.set

-- vertical split same file
keymap("n", "<leader>sv", ":vs<CR><C-w>l", { silent = true })

keymap({ "n", "v" }, "<leader>lf", function()
	vim.lsp.buf.format()
end)

keymap("n", "rn", function()
	vim.lsp.buf.rename()
end)

-- theprimeagen power maps
keymap("n", "Y", "y$")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "J", "mzJ`z")

-- dont lose your paste in visual mode
keymap("v", "<leader>p", '"_dP')

-- resource files
keymap("n", "<leader><Enter>", function()
	-- get the name of the current file
	local file = vim.fn.expand("%:t")
	print("sourced: " .. file)
	vim.cmd("source %")
end, { silent = true })

-- close buffer
keymap("n", "<leader>cc", ":bd<CR>")
keymap("n", "<leader>ca", ":%bd|e#<cr>")

-- center on scroll
keymap("n", "<C-d>", "<C-D>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- better window movement
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- better indenting
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

-- I hate escape
keymap("i", "jk", "<ESC>")
keymap("i", "kj", "<ESC>")
keymap("i", "jj", "<ESC>")

-- Move current line / block with Alt-j/k ala vscode.
keymap("n", "<A-j>", ":m .+1<CR>==", { silent = true })
keymap("n", "<A-k>", ":m .-2<CR>==", { silent = true })
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", { silent = true })
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", { silent = true })

-- QuickFix
local function deleteCurrentLine()
	-- Save the current value of 'modifiable'
	local previousModifiable = vim.o.modifiable

	-- Set 'modifiable' to 'on'
	vim.o.modifiable = true

	-- Delete the current line
	vim.cmd("normal! dd")

	-- Set 'modifiable' back to its previous value
	vim.o.modifiable = previousModifiable
end

-- function that toggles the quickfix window open and closed
function ToggleQuickFix()
	print("ToggleQuickFix 111")
	local qf_win = vim.fn.getqflist({ winid = true }).winid
	print(qf_win)
	if qf_win ~= 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

keymap("n", "<leader>dd", deleteCurrentLine, { silent = true })
keymap("n", "<leader>df", ":cfirst<CR>zz", { silent = true })
keymap("n", "<leader>dl", ":clast<CR>zz", { silent = true })
keymap("n", "<leader>dn", ":cnext<CR>zz", { silent = true })
keymap("n", "<leader>dp", ":cprev<CR>zz", { silent = true })
keymap("n", "<leader>do", ToggleQuickFix, { silent = true })

--Buffers
keymap("n", "<S-h>", ":bprev<CR>", { silent = true })
keymap("n", "<S-l>", ":bnext<CR>", { silent = true })

-- Better nav for omnicomplete
keymap("i", "<C-j>", "\\<C-n>", { silent = true })
keymap("i", "<C-k>", "\\<C-p>", { silent = true })

keymap("v", "p", "0p", { silent = true })
keymap("v", "p", "0P", { silent = true })
