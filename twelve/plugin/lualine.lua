defer_plugin({
    name = "lualine",
    packs = {
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-tree/nvim-web-devicons",
        "https://github.com/nvim-lualine/lualine.nvim",
    },
    event = "UIEnter",
    setup = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "gruvbox",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "NvimTree" },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
                lualine_c = {
                    {
                        "filename",
                        color = function()
                            return {
                                gui = "bold",
                                fg = vim.bo.modified and "#1a1a1a" or nil,
                                bg = vim.bo.modified and "#fcba03" or nil,
                            }
                        end,
                        file_status = true,
                        path = 1,
                    },
                },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress", "location" },
                lualine_z = {
                    "tabs",
                },
            },
        })
    end,
})
