local set_keymap = vim.api.nvim_set_keymap

set_keymap('n', '<leader><E>', ':source ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- close buffer
set_keymap("n", "<leader>c", ":bd<CR>", {silent = true })

-- better window movement
set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Terminal window navigation
set_keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, noremap = true })
set_keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, noremap = true })
set_keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, noremap = true })
set_keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, noremap = true })
set_keymap("i", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, noremap = true })
set_keymap("i", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, noremap = true })
set_keymap("i", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, noremap = true })
set_keymap("i", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, noremap = true })
set_keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true, noremap = true })

-- better indenting
set_keymap("v", "<", "<gv", { noremap = true, silent = true })
set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- I hate escape
set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })
set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })

-- Move current line / block with Alt-j/k ala vscode.
set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
set_keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
set_keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- QuickFix
set_keymap("n", "qn", ":cnext<CR>", { noremap = true, silent = true })
set_keymap("n", "qp", ":cprev<CR>", { noremap = true, silent = true })

--Buffers
set_keymap("n", "<S-h>", ":bprev<CR>", { noremap = true, silent = true })
set_keymap("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })

-- TREE
set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true})

-- Better nav for omnicomplete
set_keymap("i", "<C-j>", "\\<C-n>", {noremap = true, silent = true})
set_keymap("i", "<C-k>", "\\<C-p>", {noremap = true, silent = true})
-- vim.cmd 'inoremap <expr> <c-j> ("\\<C-n>")'
-- vim.cmd 'inoremap <expr> <c-k> ("\\<C-p>")'

set_keymap("v", "p", "0p", {noremap = true})
set_keymap("v", "p", "0P", {noremap = true})
-- vim.cmd 'vnoremap p "0p'
-- vim.cmd 'vnoremap P "0P'

-- TELESCOPE
set_keymap("n", "<leader>ff", ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>", {})
set_keymap("n", "<leader>fg", ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<CR>", {})
set_keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({}))<CR>", {})
set_keymap("n", "<leader>fh", ":lua require('telescope.builtin').help_tags(require('telescope.themes').get_dropdown({}))<CR>", {})
set_keymap("n", "<leader>fd", ":lua require('telescope.builtin').lsp_document_diagnostics(require('telescope.themes').get_dropdown({}))<CR>", {})

-- LSP
set_keymap("n", "rn", ":lua vim.lsp.buf.rename()<CR>", {})

set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", {})
set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", {})
set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", {})
set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", {})
set_keymap("n", "gn",":lua vim.diagnostic.goto_next()<CR>", {})
set_keymap("n", "gp",":lua vim.diagnostic.goto_prev()<CR>", {})
set_keymap("n", "gl",":lua vim.diagnostic.open_float()<CR>", {})

set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", {})
set_keymap("v", "K", ":lua vim.lsp.buf.hover()<CR>", {})

set_keymap("n", "<leader>lf", ":lua vim.lsp.buf.formatting_sync()<CR>", {})
set_keymap("v", "<leader>lf", ":lua vim.lsp.buf.formatting_sync()<CR>", {})

-- set_keymap("n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", {})
set_keymap("n", "<leader>la", ":lua require'telescope.builtin'.lsp_code_actions(require'telescope.themes'.get_dropdown({}))<CR>", {})
set_keymap("v", "<leader>la", ":lua require'telescope.builtin'.lsp_range_code_actions(require'telescope.themes'.get_dropdown({}))<CR>", {})


-- NVIM COMMENT
set_keymap("n", "<leader>/", "gcc", {silent = true})
set_keymap("v", "<leader>/", "gc", {silent = true})

-- Toggle the QuickFix window
set_keymap("", "<C-q>", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })