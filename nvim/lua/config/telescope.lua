local actions = require("telescope.actions")
local nnoremap = require("config.keymap_binds").nnoremap

nnoremap("<leader>ff", function()
    require("telescope.builtin").find_files({ hidden_files = true })
end)

nnoremap("<leader>fg", function()
    require("telescope.builtin").live_grep({ hidden_files = true })
end)

nnoremap("<leader>fr", function()
    require("telescope.builtin").grep_string({ hidden_files = true })
end)

nnoremap("<leader>fb", function()
    require("telescope.builtin").buffers()
end)

nnoremap("<leader>fe", function()
    require("telescope").extensions.file_browser.file_browser()
end)

nnoremap("<leader>fh", function()
    require("telescope.builtin").help_tags()
end)

nnoremap("<leader>fk", function()
    require("telescope.builtin").keymaps()
end)

nnoremap("<leader>ft", function()
    require("telescope.builtin").treesitter()
end)

nnoremap("<leader>fd", function()
    require("telescope.builtin").diagnostics(require("telescope.themes").get_dropdown({}))
end)

nnoremap("<leader>fs", function()
    require("telescope").extensions.npm.scripts(require("telescope.themes").get_dropdown({}))
end)

nnoremap("<leader>fp", function()
    require("telescope").extensions.npm.packages(require("telescope.themes").get_dropdown({}))
end)

require("telescope").setup({
    pickers = {
        find_files = { theme = "ivy" },
        live_grep = { theme = "ivy" },
        buffers = { theme = "ivy" },
        help_tags = { theme = "ivy" },
        treesitter = { theme = "ivy" },
    },
    defaults = {
        mappings = {
            i = {
                ["<C-x>"] = actions.select_vertical,
            },
            n = {
                ["<C-x>"] = actions.select_vertical,
            },
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = {
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            preview = { " " },
        },
        -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        path_display = {},
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },
})

-- require("telescope").load_extension("fzf")
