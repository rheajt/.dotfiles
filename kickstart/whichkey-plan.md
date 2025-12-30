# WhichKey update plan (kickstart)

## Current state
- `init.lua` registers only a few generic WhichKey groups (`<leader>c`, `<leader>d`, `<leader>s`, `<leader>t`, etc.), and some labels no longer match actual mappings (e.g., `<leader>d` is used for quickfix/diagnostics, `<leader>h` is harpoon, `<leader>c` is buffer close).
- Leader bindings are spread across multiple files (`plugin/keymaps.lua`, `plugin/quickfix.lua`, `plugin/functions.lua`, `lua/plugins/snacks/init.lua`, `lua/plugins/harpoon.lua`, `lua/plugins/ai.lua`, `lua/plugins/lsp.lua`, `lua/plugins/neorg.lua`) without WhichKey group coverage, so the popup omits or mislabels many actions (AI prompts, harpoon nav, search pickers, quickfix controls, terminal toggle, npm sidebar helper, LSP diagnostics, Neorg bindings).
- Several prefixes have clusters that should surface as subgroups: `<leader>a*` (AI actions), `<leader>d*` (quickfix), `<leader>h*` (harpoon), `<leader>s*` (Snacks pickers), `<leader>q*` (diagnostic quickfix/terminal), `<leader>l*` (Snacks dim/lazygit), plus filetype/LSP-local bindings.

## Plan
1. **Audit and define leader groups that match reality**
   - Re-label groups in `init.lua` (or a dedicated WhichKey module) so prefixes reflect current usage: Diagnostics/quickfix for `<leader>d`, Harpoon for `<leader>h`, AI for `<leader>a`, Search/Pickers for `<leader>s`, Buffers/Close for `<leader>c`, Terminal/Quick actions for `<leader>q`, Snacks/Lazy helpers for `<leader>l`.
   - Note filetype-specific prefixes (Neorg `<leader>p*`/`<leader>n*`, LSP `<leader>e`/`<leader>q`/`<leader>th`) that should register conditionally.

2. **Centralize WhichKey registrations**
   - Create a small module (e.g., `kickstart/plugin/whichkey.lua` or `lua/plugins/whichkey.lua`) that imports `which-key` and calls `which-key.add` to register both top-level groups and important sub-entries.
   - Keep plugin-defined keymaps as-is but mirror them in the WhichKey spec so the popup shows meaningful hints (e.g., quickfix submenu for `<leader>d[d/f/l/n/p/o]`, harpoon submenu for `<leader>h[a/m/n/p/1-4]`, Snacks search submenu for `<leader>s[f/b/d/h/g/k/c/e]`, AI submenu for `<leader>a[a/s/d/t/f/v/p/c]`, terminal toggle `<leader>qt`, npm sidebar `<leader>sns`, diagnostics `<leader>e/<leader>q`, inlay toggle `<leader>th`).

3. **Register context-aware bindings**
   - In LSP attach callback, call `which-key.add` with `{ buffer = event.buf }` so diagnostics and hover/type-definition mappings appear only when an LSP client is attached.
   - In Neorg setup autocmd, register `<leader>ps`, `<leader>nt`, and presentation nav keys with `buffer = true` to avoid leaking into other filetypes.

4. **Keep descriptions and grouping consistent**
   - Use concise `desc` strings in keymaps (already present) and reuse them in WhichKey entries; prefer consistent noun/verb patterns across groups.
   - Remove outdated group labels (e.g., “Document” for `<leader>d`, “Git Hunk” for `<leader>h` if harpoon is primary) to avoid misleading hints.

5. **Maintenance guidelines**
   - When adding new leader mappings, include both a `desc` and a `which-key.add` entry within the same file/module.
   - Optionally add a short comment/header in the new WhichKey module listing the files that hold leader mappings to simplify future audits.
