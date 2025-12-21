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

-- Make focused split borders more apparent + dim unfocused windows
--
-- NOTE: Neovim draws split separators from the window "owning" the edge
-- (typically the window on the left or above). To make the *focused* window
-- look framed on all sides, we set per-window `winhighlight` so:
-- - the current window uses an active separator color for its right/bottom
-- - the immediate neighbor windows (left/top) also paint their shared edge active
local function set_window_ui_highlights()
	-- Gruvbox-ish colors; tweak to taste
	vim.api.nvim_set_hl(0, "WinSeparatorActive", { fg = "#fabd2f", bold = true })
	vim.api.nvim_set_hl(0, "WinSeparatorInactive", { fg = "#3c3836" })

	-- Dim non-current windows (works well with transparent backgrounds)
	vim.api.nvim_set_hl(0, "NormalNC", { fg = "#928374" })
end

local function ranges_overlap(a1, a2, b1, b2)
	return a1 <= b2 and b1 <= a2
end

local function update_window_separators()
	local tabwins = vim.api.nvim_tabpage_list_wins(0)
	local current = vim.api.nvim_get_current_win()

	-- Baseline for all *non-floating* windows
	for _, win in ipairs(tabwins) do
		local cfg = vim.api.nvim_win_get_config(win)
		if cfg.relative == "" then
			vim.api.nvim_set_option_value(
				"winhighlight",
				"WinSeparator:WinSeparatorInactive,WinSeparatorNC:WinSeparatorInactive",
				{ win = win }
			)
		end
	end

	local cfg = vim.api.nvim_win_get_config(current)
	if cfg.relative ~= "" then
		return
	end

	local cur_row, cur_col = unpack(vim.api.nvim_win_get_position(current))
	local cur_w = vim.api.nvim_win_get_width(current)
	local cur_h = vim.api.nvim_win_get_height(current)
	local cur_row2 = cur_row + cur_h - 1
	local cur_col2 = cur_col + cur_w - 1

	-- Windows that "own" the separators for the focused window's left/top edges.
	local left_neighbors = {}
	local top_neighbors = {}

	for _, win in ipairs(tabwins) do
		if win ~= current then
			local wcfg = vim.api.nvim_win_get_config(win)
			if wcfg.relative == "" then
				local row, col = unpack(vim.api.nvim_win_get_position(win))
				local w = vim.api.nvim_win_get_width(win)
				local h = vim.api.nvim_win_get_height(win)
				local row2 = row + h - 1
				local col2 = col + w - 1

				-- window(s) immediately to the left; their right separator borders current
				if col + w + 1 == cur_col and ranges_overlap(row, row2, cur_row, cur_row2) then
					table.insert(left_neighbors, win)
				end

				-- window(s) immediately above; their bottom separator borders current
				if row + h + 1 == cur_row and ranges_overlap(col, col2, cur_col, cur_col2) then
					table.insert(top_neighbors, win)
				end
			end
		end
	end

	-- Make current window draw its right/bottom separators as active.
	vim.api.nvim_set_option_value(
		"winhighlight",
		"WinSeparator:WinSeparatorActive,WinSeparatorNC:WinSeparatorActive",
		{ win = current }
	)

	-- Make neighbor windows draw their separators as active too, so the focused
	-- window looks framed on left/top edges.
	for _, win in ipairs(left_neighbors) do
		vim.api.nvim_set_option_value(
			"winhighlight",
			"WinSeparator:WinSeparatorInactive,WinSeparatorNC:WinSeparatorActive",
			{ win = win }
		)
	end

	for _, win in ipairs(top_neighbors) do
		vim.api.nvim_set_option_value(
			"winhighlight",
			"WinSeparator:WinSeparatorInactive,WinSeparatorNC:WinSeparatorActive",
			{ win = win }
		)
	end
end

local window_ui_group = vim.api.nvim_create_augroup("kickstart-window-ui", { clear = true })

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	group = window_ui_group,
	callback = function()
		set_window_ui_highlights()
		update_window_separators()
	end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "WinNew", "WinClosed", "VimResized", "TabEnter" }, {
	group = window_ui_group,
	callback = update_window_separators,
})

-- Alacritty: let <C-=> / <C--> pass through while Neovim runs.
-- We rely on Alacritty keybindings using `mode = "~AppKeypad"` for font resizing.
vim.api.nvim_create_autocmd("UIEnter", {
	group = window_ui_group,
	callback = function()
		-- Enable DECKPAM (Application Keypad mode)
		vim.api.nvim_out_write("\x1b=")
	end,
})

vim.api.nvim_create_autocmd("UILeave", {
	group = window_ui_group,
	callback = function()
		-- Disable DECKPAM
		vim.api.nvim_out_write("\x1b>")
	end,
})

print("autocmds loaded")
