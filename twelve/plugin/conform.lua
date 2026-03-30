vim.pack.add({
    'https://github.com/stevearc/conform.nvim'
})

require('conform').setup({
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
        local disable_filetypes = { c = true, cpp = true }
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

vim.keymap.set(
    "n",
    "<leader>f",
    function() 
        require('conform').format({async = true, lsp_fallback = true})
    end,
    {desc = "[F]ormat buffer"}
)
