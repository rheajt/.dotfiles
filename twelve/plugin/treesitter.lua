-- Treesitter is deferred to BufReadPost -- highlighting is not needed until
-- a real file is displayed. The PackChanged autocmd stays eager (cheap, just
-- registers a callback).

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

defer_plugin({
    name = "treesitter",
    packs = { "https://github.com/nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    setup = function() end,
})
