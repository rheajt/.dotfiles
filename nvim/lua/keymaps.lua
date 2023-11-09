-- local nnoremap = require("config.keymap_binds").nnoremap
local vnoremap = require("config.keymap_binds").vnoremap
local inoremap = require("config.keymap_binds").inoremap
local xnoremap = require("config.keymap_binds").xnoremap
local keymap = vim.keymap.set

-- vertical split same file
vim.keymap.set("n", "<leader>sv", ":vs<CR><C-w>l", { silent = true })

-- vim.keymap.set("n", "gp", "")
-- vim.keymap.set("n", "gn", "")
-- vim.keymap.set("n", "gl", "")
-- vim.keymap.set("n", "gc", "")

-- vim.keymap.set("n", "gh", "")
-- vim.keymap.set("n", "gd", "")
-- vim.keymap.set("n", "gt", "")
-- vim.keymap.set({ "n", "v" }, "K", "vim.lsp.buf.hover()<CR>")
-- vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>")
-- vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>Lspsaga term_toggle<CR>")

vim.keymap.set("n", "<leader>lf", function()
	vim.lsp.buf.format()
end)
keymap("v", "<leader>lf", function()
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
keymap("n", "<leader><Enter>", ":source ~/.config/nvim/init.lua<CR>")

-- close buffer
keymap("n", "<leader>cc", ":bd<CR>")
keymap("n", "<leader>ca", ":%bd|e#<cr>")

-- center on scroll
keymap("n", "<C-d>", "<C-D>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- better window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Terminal window navigation
-- nnoremap("<leader>t", ":vs<CR>:terminal<CR>", { silent = true })
-- tnoremap("<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
-- tnoremap("<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
-- tnoremap("<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
-- tnoremap("<C-l>", "<C-\\><C-N><C-w>l", { silent = true })
-- tnoremap("<Esc>", "<C-\\><C-n>", { silent = true })
-- inoremap("<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
-- inoremap("<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
-- inoremap("<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
-- inoremap("<C-l>", "<C-\\><C-N><C-w>l", { silent = true })

-- better indenting
vnoremap("<", "<gv", { silent = true })
vnoremap(">", ">gv", { silent = true })

-- I hate escape
keymap("i", "jk", "<ESC>")
keymap("i", "kj", "<ESC>")
keymap("i", "jj", "<ESC>")

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
inoremap("<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
inoremap("<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
xnoremap("<A-j>", ":m '>+1<CR>gv-gv", { silent = true })
xnoremap("<A-k>", ":m '<-2<CR>gv-gv", { silent = true })

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
vim.keymap.set("n", "<leader>dd", deleteCurrentLine)
vim.keymap.set("n", "<leader>dn", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>dp", ":cprev<CR>", { silent = true })
vim.keymap.set("n", "<leader>dc", ":ccl<CR>", { silent = true })

--Buffers
vim.keymap.set("n", "<S-h>", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })

-- Better nav for omnicomplete
inoremap("<C-j>", "\\<C-n>", { silent = true })
inoremap("<C-k>", "\\<C-p>", { silent = true })

vnoremap("p", "0p", { silent = true })
vnoremap("p", "0P", { silent = true })

-- TSLsp keymaps
-- nnoremap("ts", ":TSLspOrganize<CR>")
-- nnoremap("tr", ":TSLspRenameFile<CR>")
-- nnoremap("ti", ":TSLspImportAll<CR>")
