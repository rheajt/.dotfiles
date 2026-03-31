-- Conform is only needed when a buffer is open (format-on-save, manual format).
-- The keymap is defined eagerly but calls ensure_conform() on first use.

local conform_loaded = false
local function ensure_conform()
    if conform_loaded then
        return
    end
    conform_loaded = true
    vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
    require("conform").setup({
        formatters = {
            stylua = {
                opts = {
                    indent_type = "Spaces",
                    indent_width = 4,
                },
            },
            injected = {
                options = {
                    ft_parsers = {
                        handlebars = "angular",
                    },
                },
            },
        },
        notify_on_error = true,
        format_on_save = function(bufnr)
            local disable_filetypes = { hbs = true, c = true, cpp = true }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            typescript = { "prettierd" },
            javascript = { "prettierd" },
            typescriptreact = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            html = { "prettierd" },
            css = { "prettierd" },
            scss = { "prettierd" },
            gql = { "prettierd" },
            graphql = { "prettierd" },
            sh = { "beautysh" },
            markdown = { "prettierd" },
            sql = { "sleek" },
            xml = { "lemminx" },
        },
    })
end

-- Load conform when a real file is opened (for format_on_save)
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("twelve-defer-conform", { clear = true }),
    once = true,
    callback = function()
        ensure_conform()
    end,
})

-- Keymap is always available; loads conform on first press if not already loaded
vim.keymap.set("n", "<leader>f", function()
    ensure_conform()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]ormat buffer" })
