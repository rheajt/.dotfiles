defer_plugin({
    name = "tmux",
    packs = { "https://github.com/aserowy/tmux.nvim" },
    event = "UIEnter",
    setup = function()
        require("tmux").setup({
            copy_sync = {
                enable = true,
                ignore_buffers = { empty = false },
                redirect_to_clipboard = false,
                register_offset = 0,
                sync_clipboard = true,
                sync_registers = true,
                sync_deletes = true,
                sync_unnamed = true,
            },
            navigation = {
                cycle_navigation = true,
                enable_default_keybindings = true,
                persist_zoom = false,
            },
            resize = {
                enable_default_keybindings = true,
                resize_step_x = 1,
                resize_step_y = 1,
            },
        })
    end,
})
