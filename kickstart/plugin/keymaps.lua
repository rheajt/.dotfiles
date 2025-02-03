-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- close buffer
vim.keymap.set("n", "<leader>cc", ":bd<CR>", { desc = "[C]lose [C]urrent Buffer" })
vim.keymap.set("n", "<leader>ca", ":%bd|e#<cr>", { desc = "[C]lose [A]ll Buffers" })

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv-gv", { silent = true })
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv-gv", { silent = true })

-- I hate escape
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("i", "jj", "<ESC>")

-- theprimeagen power maps
vim.keymap.set("n", "Y", "y$", { desc = "[Y]ank to the end of the link" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center [n]ext search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center [N]ext search result" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "[J]oin lines and keep cursor position" })

-- dont lose your paste in visual mode
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "[P]aste without yanking" })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier. Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

print("keymaps loaded")
