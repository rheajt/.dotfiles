local nnoremap = require("config.keymap_binds").nnoremap
local vnoremap = require("config.keymap_binds").vnoremap
local inoremap = require("config.keymap_binds").inoremap
local xnoremap = require("config.keymap_binds").xnoremap
local keymap = vim.keymap.set

-- vertical split same file
keymap("n", "<leader>sv", ":vs<CR><C-w>l", { silent = true })

keymap("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>")
keymap("n", "gc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
keymap({ "n", "v" }, "K", "<cmd>Lspsaga hover_doc<CR>")
keymap({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>")
keymap({ "n", "t" }, "<leader>tt", "<cmd>Lspsaga term_toggle<CR>")

keymap("n", "<leader>lf", function()
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
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

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
nnoremap("<A-j>", ":m .+1<CR>==", { silent = true })
nnoremap("<A-k>", ":m .-2<CR>==", { silent = true })
inoremap("<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
inoremap("<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
xnoremap("<A-j>", ":m '>+1<CR>gv-gv", { silent = true })
xnoremap("<A-k>", ":m '<-2<CR>gv-gv", { silent = true })

-- QuickFix
nnoremap("<leader>dn", ":cnext<CR>", { silent = true })
nnoremap("<leader>dp", ":cprev<CR>", { silent = true })
nnoremap("<leader>dc", ":ccl<CR>", { silent = true })

--Buffers
nnoremap("<S-h>", ":bprev<CR>", { silent = true })
nnoremap("<S-l>", ":bnext<CR>", { silent = true })

-- Better nav for omnicomplete
inoremap("<C-j>", "\\<C-n>", { silent = true })
inoremap("<C-k>", "\\<C-p>", { silent = true })

vnoremap("p", "0p", { silent = true })
vnoremap("p", "0P", { silent = true })

-- TSLsp keymaps
-- nnoremap("ts", ":TSLspOrganize<CR>")
-- nnoremap("tr", ":TSLspRenameFile<CR>")
-- nnoremap("ti", ":TSLspImportAll<CR>")
