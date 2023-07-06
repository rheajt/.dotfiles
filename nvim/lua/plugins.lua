local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "kyazdani42/nvim-web-devicons",

    -- {
    --     "glacambre/firenvim",
    --     build = function()
    --         vim.fn["firenvim#install"](0)
    --     end,
    -- },

    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    -- {
    --     "simrat39/symbols-outline.nvim",
    --     config = function()
    --         require("symbols-outline").setup()
    --     end,
    -- },

    -- undotree
    -- {
    --     "mbbill/undotree",
    --     config = function()
    --         vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })
    --     end,
    -- },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("config.telescope")
        end,
    },

    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    "elianiva/telescope-npm.nvim",

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("config.treesitter")
        end,
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },

    --Autopairs
    -- {
    --     "windwp/nvim-autopairs",
    --     config = function()
    --         require("nvim-autopairs").setup({})
    --     end,
    -- },

    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    -- Tree
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("config.nvim-tree")
        end,
    },

    -- Status Line
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("config.lualine")
        end,
    },

    -- Nvim Comment
    {
        "terrortylor/nvim-comment",
        config = function()
            require("config.nvim-comment")
        end,
    },

    -- git signs
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- Lua
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },

    -- copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
            })
        end,
    },

    -- neorg
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers", -- This is the important bit!
        version = "4.0.1",
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            work = "~/notes/work",
                            home = "~/notes/home",
                        },
                        default_workspace = "work",
                    },
                },
                ["core.concealer"] = {
                    config = {
                        folds = false,
                    },
                },
                ["core.integrations.telescope"] = {},
            },
        },
        dependencies = { { "nvim-neorg/neorg-telescope" } },
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
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
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.diagnostics.tsc,
                },
            })
        end,
    },

    "jose-elias-alvarez/nvim-lsp-ts-utils",

    {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        config = function()
            require("lspsaga").setup({
                diagnostic = {
                    on_insert = false,
                },
                lightbulb = {
                    enable = false,
                },
                code_action = {
                    num_shortcut = true,
                    keys = {
                        quit = "q",
                        exec = "<CR>",
                    },
                },
            })
        end,
        dependencies = {
            -- { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" },
        },
    },

    "luisiacc/gruvbox-baby",
    "sekke276/dark_flat.nvim",
})
