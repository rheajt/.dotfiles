local nnoremap = require("config.keymap_binds").nnoremap
local vnoremap = require("config.keymap_binds").vnoremap

nnoremap("rn", function()
	vim.lsp.buf.rename()
end)

nnoremap("gd", function()
	vim.lsp.buf.definition()
end)

nnoremap("gD", function()
	vim.lsp.buf.declaration()
end)

nnoremap("gr", function()
	vim.lsp.buf.references()
end)

nnoremap("gR", function()
	vim.lsp.buf.references()
end)

nnoremap("gi", function()
	vim.lsp.buf.implementation()
end)

nnoremap("gh", function()
	vim.lsp.buf.signature_help()
end)

nnoremap("gn", function()
	vim.diagnostic.goto_next()
end)

nnoremap("gp", function()
	vim.diagnostic.goto_prev()
end)

nnoremap("gl", function()
	vim.diagnostic.open_float()
end)

nnoremap("K", function()
	vim.lsp.buf.hover()
end)
vnoremap("K", function()
	vim.lsp.buf.hover()
end)

nnoremap("<leader>lf", function()
	vim.lsp.buf.format()
end)
vnoremap("<leader>lf", function()
	vim.lsp.buf.format()
end)
nnoremap("<leader>la", function()
	vim.lsp.buf.code_action()
end)
vnoremap("<leader>la", function()
	vim.lsp.buf.range_code_action()
end)

require("config.lsp.lsp-startup")
-- require("config.lsp.lsp-emmet")
