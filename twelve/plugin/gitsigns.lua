-- Gitsigns only matters when viewing a real file in a git repo.
defer_plugin({
    name = "gitsigns",
    packs = { "https://github.com/lewis6991/gitsigns.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    setup = function()
        require("gitsigns").setup({
            signcolumn = true,
        })
    end,
})
