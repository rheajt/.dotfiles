-- mini.basics is intentionally omitted -- settings.lua covers all its options.
-- surround/ai/comment are deferred to UIEnter since they are editing helpers.

defer_plugin({
    name = "mini",
    packs = { "https://github.com/nvim-mini/mini.nvim" },
    event = "UIEnter",
    setup = function()
        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })
        require("mini.comment").setup()
    end,
})
