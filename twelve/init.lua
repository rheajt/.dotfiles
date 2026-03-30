vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- I hate escape
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set("n", "<leader>cc", ":bd<CR>", { desc = "[C]lose [C]urrent Buffer" })
-- vim.keymap.set("n", "<leader>ca", ":%bd|e#<cr>", { desc = "[C]lose [A]ll Buffers" })

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv-gv", { silent = true })
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv-gv", { silent = true })

-- theprimeagen power maps
vim.keymap.set("n", "Y", "y$", { desc = "[Y]ank to the end of the link" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center [n]ext search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center [N]ext search result" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "[J]oin lines and keep cursor position" })

-- dont lose your paste in visual mode
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "[P]aste without yanking" })

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.cmd.colorscheme("catppuccin")
