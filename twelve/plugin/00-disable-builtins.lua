-- Disable built-in plugins that are unused or replaced by other plugins.
-- This file is prefixed with 00- to ensure it runs before anything else.

-- netrw is replaced by snacks.explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- matchit is replaced by treesitter
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- archive browsing -- rarely used
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_zip = 1

-- remote plugins -- not used
vim.g.loaded_rplugin = 1

-- tutor -- not needed at startup
vim.g.loaded_tutor_mode_plugin = 1
