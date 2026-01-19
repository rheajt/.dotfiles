-- [[ Basic Autocommands ]] See `:help lua-guide-autocommands`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		print("Yanked")
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		-- local name = vim.api.nvim_buf_get_name(0)
		-- print("Buffer Entered: " .. name)

		-- disable copilot if the name is empty
		-- if name == "" then
		-- 	vim.b.copilot_enabled = false
		-- end
		-- if name:match("snacks%") then
		-- 	vim.b.copilot_enabled = false
		-- end
	end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client and client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
-- 		print("LspAttached")
-- 	end,
-- })

print("autocmds loaded")
