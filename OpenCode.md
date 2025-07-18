# OpenCode Guidelines

## Build, Lint, and Test

- **Shell scripts:** No build/lint step—ensure scripts have execute permissions (`chmod +x file`).
- **TypeScript/JS:**
  - Run scripts with `bun file.ts` or `node file.js` (make sure Bun/Node.js is installed).
  - No standard linter; follow TypeScript/Node.js conventions.
- **NPM scripts:** If a `package.json` is present, use `bash-scripts/package-scripts` to run scripts interactively.
- **Lua (neovim plugins):** No explicit build/test. Edit and reload in Neovim to test changes.

## Code Style Guidelines

- **Shell:** Use `#!/usr/bin/env bash` or `#!/usr/bin/bash` as appropriate. Use readable, portable Bash style. Prefer double brackets (`[[ ]]`) for conditionals.
- **TypeScript/JS:** 
  - Use ES module imports (`import ... from ...`).
  - Prefer `const` and `let`; avoid `var`.
  - Consistent indentation (2 spaces).
  - Use descriptive, camelCase names for variables/functions.
  - Handle errors (e.g. check for undefined, use `try/catch` where appropriate).
  - Keep scripts concise—prefer pure functions and minimal side effects.
- **Lua:** 
  - Use consistent 2-space indentation.
  - Prefer `local` for function/variable scope.
  - Lowercase snake_case for functions/variables, UpperCamel for classes/modules.
  - Use descriptive names and short docstrings for clarity.
- **General:** Avoid trailing whitespace. Keep lines <100 chars. Add shebang to executable scripts.

## Extra Tips

- For Neovim plugins: reload Neovim to test changes.
- For new scripts: place Bash in `bash-scripts/`, TypeScript in `scripts/`, config in relevant directories.
- Document new scripts or commands in `README.md` if needed.
