# Bash Scripts Overview

This document summarizes the purpose and functionality of each script in the `bash-scripts` directory.

---

- **cgpt**  
  Interactive Zsh wrapper that prompts user for input, sends it to ChatGPT (gpt-4.1), displays the response, and logs prompt/response pairs to `~/.config/cgpt/prompts.md`.

- **chatgpt-prompt**  
  Bash tool for running various prompts (grammar correction, keyword extraction, code readability), intended for working with text/code files.

- **clasp-push-complete**  
  Shows a desktop notification and plays an audio sound upon successful `clasp push` (Google Apps Script deploy/commit).

- **current-spotify**  
  Uses `spd-say` to speak the currently playing Spotify track, grabbing info from a `sp` command.

- **finder**  
  Flexible launcher/search helper for Rofi, allows searching/opening files, URLs, or running actions based on the query.

- **fkill**  
  Fzf-powered interface to select and kill running processes by PID.

- **flameshot**  
  Launches the Flameshot screenshot tool in GUI mode.

- **getgo**  
  Helps install, upgrade, or manage versions of the Go programming language (requires curl and jq). Based on GitHub repo by Mohamed Attahri.

- **i3-battery-popup**  
  Script to show battery warnings/notifications in i3, with support for multiple batteries and customizable percentage thresholds.

- **i3_scratchpad_show**  
  Shows an i3 scratchpad window with correct sizing/position. Useful for launching or restoring hidden scratchpad apps.

- **i3_sidebar_show**  
  Like i3_scratchpad_show, but for a sidebar window, adjusting its width to 1/3 of the screen.

- **lock**  
  Locks the screen with `i3lock` and selects a random background image from `~/Pictures/backgrounds`.

- **new-tmux-session**  
  Automatically creates or attaches to a tmux session named after the project directory or package.json 'name', renaming the window to 'code'.

- **new-workspace**  
  Switches to a new i3 workspace with the next available number.

- **norg-rofi-menu**  
  Creates new notes for Norg using Rofi to prompt for file names, optionally opens them in a terminal.

- **omni**  
  Wrapper to fullscreen and play a specific video file with VLC.

- **package-scripts**  
  Uses jq and fzf to browse and run npm scripts from package.json interactively.

- **power-switcher**  
  Rofi menu for toggling power profiles on System76 hardware (Battery, Balanced, Performance).

- **projects**  
  Interactive fzf-driven switcher to cd into a selected project directory under `~/projects`.

- **ps-project**  
  Clones a Powerschool project repo from GitHub using a provided project name & branch (defaults to 'solid').

- **random-bg**  
  Applies a random background from `~/Pictures/backgrounds/$BG_DIR/` (default 'maps') with feh.

- **reset-chrome**  
  Deletes Chrome's `Login Data` files in the current directory.

- **screens**  
  Rofi menu for switching between single/mirror/multi-display setups, with i3 and xrandr management.

- **sessions**  
  Fzf interface to select and attach to a running tmux session, or switch if already in tmux.

- **set-charging-profile**  
  Lets a user select charging profile ("Full Charge", "Balanced", "Max Lifespan") for System76 hardware.

- **sfa**  
  Uses fzf to select an audio file from `~/Music/sfa3` and plays it using mpg123.

- **sound-menu**  
  Uses fd and rofi to find and play music files from `~/Music/sfa3` with mpg123.

- **sp**  
  CLI interface for controlling Spotify over D-Bus. Can search, play, pause, and display song info.

- **tmux-cht.sh**  
  Uses fzf to search language/command snippets, then queries `cht.sh` and displays the result with batcat.

- **tmux-split-right**  
  Sends a command to the right pane in tmux or splits the window if not present.

- **to-pdf**  
  Converts a Markdown file to PDF using pandoc with XeLaTeX.

- **toggle-morgen**  
  Uses i3_scratchpad_show to toggle the 'morgen' (calendar) app as a scratchpad.

- **toggle-spotify**  
  Uses i3_scratchpad_show to toggle Spotify as a scratchpad.

---
