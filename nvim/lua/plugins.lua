-- local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute("packadd packer.nvim")
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
    return
end

packer.init({
    git = { clone_timeout = 300 },
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
})

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("kyazdani42/nvim-web-devicons")

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })

    use({
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup()
        end,
    })
    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        config = function()
            require("config.telescope")
        end,
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("elianiva/telescope-npm.nvim")

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("config.treesitter")
        end,
    })
    use("nvim-treesitter/nvim-treesitter-context")
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    })

    --Autopairs
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    use({
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    })

    -- Tree
    use({
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("config.nvim-tree")
        end,
    })

    -- Status Line
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("config.lualine")
        end,
    })

    -- Nvim Comment
    use({
        "terrortylor/nvim-comment",
        config = function()
            require("config.nvim-comment")
        end,
    })

    -- git signs
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    })

    -- Lua
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use({
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers", -- This is the important bit!
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.norg.dirman"] = {
                        config = {
                            workspaces = {
                                work = "~/notes/work",
                                home = "~/notes/home",
                            },
                            default_workspace = "work"
                        }
                    },
                    ["core.norg.completion"] = {
                        config = {
                            engine = "nvim-cmp"
                        }
                    },
                    ["core.norg.concealer"] = {},
                    ["core.presenter"] = {
                        config = {
                            zen_mode = "zen-mode"
                        }
                    }
                },
            })
        end,
    })

    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    })

    use("luisiacc/gruvbox-baby")
    use({ "catppuccin/nvim", as = "catppuccin" })
    use("rebelot/kanagawa.nvim")
end)
