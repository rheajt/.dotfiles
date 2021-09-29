local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

packer.init {
  -- package_root = require("packer.util").join_paths(vim.fn.stdpath "data", "lvim", "pack"),
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

return require("packer").startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- Nvim Comment
    use {
        'terrortylor/nvim-comment',
        config = function()
            require "nvim_comment".setup({
                comment_empty = false
            })
        end,
    }

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
      config = function()
          require('tscope')
      end,
    }

    -- LSP
    use { "neovim/nvim-lspconfig" }
    use {
        "kabouzeid/nvim-lspinstall",
        config = function()
            require('lspinstall').setup()
            local settings = require('lang-server-settings')
            local servers = require('lspinstall').installed_servers()
            for _, server in pairs(servers) do
                require'lspconfig'[server].setup{
                   settings[server]
                }
            end
        end,
    }

    -- Autocomplete
      use {
        "hrsh7th/nvim-compe",
        -- event = "InsertEnter",
        config = function()
          require("completer").config()
        end,
      }

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter" }

    -- Colorscheme
	use { 'gruvbox-community/gruvbox' }
end)

