vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Deferred loading helpers for vim.pack.add
-- ============================================================================

-- Guard table to track which plugins have been loaded
_G._twelve_loaded = {}

--- Defer a plugin load + setup to a specific event.
--- @param opts table
---   - packs: table -- argument to pass to vim.pack.add()
---   - event: string|string[] -- autocmd event(s) to trigger on
---   - pattern?: string|string[] -- optional autocmd pattern
---   - setup: function -- called once after pack.add; receives the autocmd event args
function _G.defer_plugin(opts)
	local loaded = false
	vim.api.nvim_create_autocmd(opts.event, {
		group = vim.api.nvim_create_augroup("twelve-defer-" .. (opts.name or "anon"), { clear = true }),
		pattern = opts.pattern,
		once = true,
		callback = function(ev)
			if loaded then
				return
			end
			loaded = true
			vim.pack.add(opts.packs)
			if opts.setup then
				vim.schedule(function()
					opts.setup(ev)
				end)
			end
		end,
	})
end

-- ============================================================================
-- Core keymaps (cheap -- always load immediately)
-- ============================================================================
require("config.settings")
require("config.keymaps")
vim.lsp.codelens.enable(true)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		print("Yanked")
		vim.highlight.on_yank()
	end,
})
