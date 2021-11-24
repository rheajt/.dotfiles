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

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvimtree'
        end
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = function()
          require'lualine'.setup {
              options = {
                icons_enabled = true,
                theme = 'gruvbox_dark',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {},
                always_divide_middle = true,
              },
              sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff',
                              {'diagnostics', sources={'nvim_lsp'}}},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
              },
              inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                -- lualine_c = {'filename'},
                -- lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
              },
              tabline = {},
              extensions = {}
            }
        end
    }

    -- Nvim Comment
    use {
        'terrortylor/nvim-comment',
        config = function()
            require "nvim_comment".setup({
                comment_empty = false
            })
        end,
    }

    use {"L3MON4D3/LuaSnip"}

    -- Telescope
    use "nvim-lua/plenary.nvim"
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
      config = function()
          require('tscope')
      end,
    }

    use { "elianiva/telescope-npm.nvim" }

    -- LSP
    use { "neovim/nvim-lspconfig" } 
    use { 'williamboman/nvim-lsp-installer', 
        -- config = function () require'lsp-startup' end,
    }

    -- use {
    --     "kabouzeid/nvim-lspinstall",
    --     requires = "neovim/nvim-lspconfig",
    --     config = function()
    --         local servers = require'lspinstall'.installed_servers()
    --         for _, server in pairs(servers) do
    --             require'lspconfig'[server].setup{}
    --         end
    --     end,
    -- }

    -- Autocomplete
    use {
        "hrsh7th/nvim-cmp",
        config = function()
            require'completer'
        end,
    }
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "saadparwaiz1/cmp_luasnip"

    use "onsails/lspkind-nvim"

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter" }

    -- Colorscheme
	use { 'gruvbox-community/gruvbox' }
end)

