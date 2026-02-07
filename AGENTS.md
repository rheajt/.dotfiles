# Agent Guide for dotfiles

This repository is a personal dotfiles collection with a mix of shell scripts,
Neovim Lua config, and small JS/TS utilities. There is no single build system.
Use the notes below to pick the right workflow and keep edits consistent.

## Quick Repo Map

- `bash-scripts/`: executable helpers and CLI utilities (bash/zsh).
- `scripts/`: small JS/TS utilities (run with Bun or Node).
- `kickstart/`: Neovim config (Lua).
- Config files at repo root (`tmux.conf`, `i3config`, `alacritty.toml`, etc.).

## Build, Lint, and Test Commands

### Repo-level

- No global build/lint/test commands are defined.
- There is no top-level `package.json` or test runner.
- When in doubt, run the script you edited directly.

### Shell scripts (bash/zsh)

- Run a script directly once it is executable:
  - `chmod +x bash-scripts/<script>`
  - `./bash-scripts/<script>`
- No lint step is configured. If you add one, prefer `shellcheck` and `beautysh`.

### JS/TS scripts

- Run TS/JS utilities with Bun or Node:
  - `bun scripts/<file>.ts`
  - `node scripts/<file>.js`
- No standard lint/test setup. Use project-local instructions when present.

### Neovim Lua (kickstart)

- No build or test steps.
- Reload Neovim to validate changes.
- Treesitter updates are managed inside Neovim (`:TSUpdate`).

### Single test guidance

- There are no repo-wide tests.
- If a subproject introduces tests, follow its local README or `package.json`.
- For Node-style tests, a common pattern is:
  - `npm run test -- <pattern>` (only if the project defines it).

### Script picker helper

- If you are inside a project with `package.json`, use:
  - `bash-scripts/package-scripts`
  - This launches an fzf picker for `npm run` scripts.

## Code Style Guidelines

### General

- Keep edits minimal and consistent with surrounding files.
- Avoid trailing whitespace; prefer lines under 100 characters.
- Use ASCII text unless the file already contains Unicode.
- Add comments only when the intent is not obvious from the code.

### Shell (bash)

- Use `#!/usr/bin/env bash` (or `#!/usr/bin/bash` where required).
- Prefer `set -e` at the top for script safety when appropriate.
- Use `[[ ... ]]` for conditionals and quote variables (`"$var"`).
- Check dependencies with `command -v <tool>` and exit with helpful errors.
- Use readable, portable Bash; avoid bashisms that break in `sh`.
- Indentation is typically 4 spaces in the scripts.

### Shell (zsh)

- Use `#!/usr/bin/zsh` for zsh-only helpers.
- Prefer `local` for function or block-scoped variables.
- Keep interactive scripts concise; use fzf/rofi patterns consistently.

### JavaScript / TypeScript

- Use ES module imports (`import ... from ...`).
- Prefer `const` and `let`; avoid `var`.
- Use descriptive `camelCase` names for variables and functions.
- Prefer small, focused functions with clear side effects.
- Handle errors explicitly (check for missing files or empty output).
- Formatting is generally 4 spaces (Prettier configured with `tabWidth: 4`).

### Lua (Neovim config)

- Prefer `local` for module scope.
- Use `snake_case` for variables/functions; `UpperCamel` for modules.
- Keep plugin config tables readable and grouped by feature.
- Formatting uses Stylua with 4-space indentation.

### JSON / TOML / INI

- Match existing indentation and key ordering in the file you touch.
- Keep values explicit; avoid trailing commas in JSON.

### Markdown

- Keep headings short and descriptive.
- Wrap long sentences to keep lines below 100 characters.

## Error Handling Patterns

- Shell: exit early with a clear error message if inputs are missing.
- Shell: validate file paths and numeric inputs before use.
- JS/TS: guard for empty output from commands or missing files.
- Lua: surface errors early (e.g., during plugin setup).

## Imports and Dependencies

- JS/TS uses ESM imports.
- Lua uses `require` and lazy-loaded plugin specs.
- Avoid introducing new global dependencies unless necessary.

## Naming Conventions

- Shell variables: uppercase for constants, lowercase for locals.
- JS/TS variables/functions: `camelCase`; constants may be `UPPER_SNAKE`.
- Lua: `snake_case` for functions/variables.

## Formatting and Tooling Notes

- Neovim config uses `conform.nvim` for formatting:
  - `stylua` for Lua, 4-space indentation.
  - `prettierd` / `prettier` for JS/TS/JSON/HTML/CSS, 4-space tab width.
  - `beautysh` for shell scripts.
- Keep formatters optional; do not reformat unrelated files.

## Files to Prefer for Changes

- New bash utilities go in `bash-scripts/` with execute permissions.
- New JS/TS helpers go in `scripts/` and run with Bun/Node.
- Neovim changes go in `kickstart/` following existing plugin layout.

## Documentation Expectations

- Update `README.md` or `bash-scripts.md` if you add user-facing scripts.
- Keep instructions concise and aligned with existing docs.

## Cursor/Copilot Rules

- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md`
  files are present in this repo as of the latest scan.

## Safety Notes for Agents

- Do not delete or rewrite user files without an explicit request.
- Avoid destructive git commands.
- When unsure, ask before changing behavior in global configs.
