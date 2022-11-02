local nnoremap = require("config.keymap_binds").nnoremap
local vnoremap = require("config.keymap_binds").vnoremap
local tnoremap = require("config.keymap_binds").tnoremap
local inoremap = require("config.keymap_binds").inoremap
local xnoremap = require("config.keymap_binds").xnoremap

-- vertical split same file
nnoremap("<leader>sv", ":vs<CR><C-w>l", { silent = true })

-- theprimeagen power maps
nnoremap("Y", "y$")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
nnoremap(",", ",<C-g>u")
nnoremap(".", ".<C-g>u")
nnoremap("!", "!<C-g>u")
nnoremap("?", "?<C-g>u")

-- dont lose your paste in visual mode
vnoremap("<leader>p", '"_dP')

-- resource files
nnoremap("<leader><Enter>", ":source ~/.config/nvim/init.lua<CR>:source %<CR>")

-- close buffer
nnoremap("<leader>cc", ":bd<CR>")
nnoremap("<leader>ca", ":%bd|e#<cr>")

-- center on scroll
nnoremap("<C-d>", "<C-D>zz")
nnoremap("<C-u>", "<C-u>zz")

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
inoremap("jk", "<ESC>")
inoremap("kj", "<ESC>")
inoremap("jj", "<ESC>")

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
nnoremap("ts", ":TSLspOrganize<CR>")
nnoremap("tr", ":TSLspRenameFile<CR>")
nnoremap("ti", ":TSLspImportAll<CR>")
