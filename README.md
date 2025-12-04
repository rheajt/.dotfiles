# .dotfiles

a collection of my dotfiles

## Setup

### Zsh Configuration

To set up zsh configuration:

1. Clone this repository
2. Run the setup script:
   ```bash
   cd zsh
   ./link-files.sh
   ```

This will create symbolic links for your zsh configuration:
- `~/.zshenv` → `~/.config/zsh/zshenv`
- `~/.config/zsh` → `/path/to/dotfiles/zsh`

The configuration will be automatically loaded when you start zsh.

## Directory stucture
├── alacritty.yml
├── bash-scripts
│   ├── clasp-push-complete
│   ├── finder
│   ├── fkill
│   ├── flameshot
│   ├── getgo
│   ├── i3-battery-popup
│   ├── i3_scratchpad_show
│   ├── lf
│   ├── lock
│   ├── new-tmux-session
│   ├── new-workspace
│   ├── omni
│   ├── open-chrome
│   ├── open-chrome-andprosper
│   ├── open-chrome-default
│   ├── open-chrome-work
│   ├── open-edge-keystone
│   ├── open-edge-psisjs
│   ├── power-switcher
│   ├── projects
│   ├── ps-project
│   ├── random-bg
│   ├── reset-chrome
│   ├── screens
│   ├── sessions
│   ├── set-charging-profile
│   ├── sfa
│   ├── sound-menu
│   ├── sp
│   ├── tmux-cht.sh
│   └── toggle-spotify
├── config.fish
├── config.rasi
├── finder.sh
├── i3config
├── i3status
├── kickstart
│   ├── init.lua
│   ├── lazy-lock.json
│   └── lua
│       └── custom
│           └── plugins
│               ├── chatgpt.lua
│               ├── colorizer.lua
│               ├── colorschemes.lua
│               ├── copilot.lua
│               ├── harpoon.lua
│               ├── lualine.lua
│               ├── neorg.lua
│               ├── neotest.lua
│               ├── noice.lua
│               ├── nvim-treesitter-context.lua
│               ├── tmux.lua
│               ├── trouble.lua
│               └── typescript-tools.lua
├── LICENSE
├── newsboat.urls
├── polybar-config.ini
├── polybar-launch.sh
├── README.md
├── scripts
│   ├── quotes
│   └── random-quote.js
├── terminal
│   └── settings.json
├── tmux
│   ├── tmux-cht-command
│   └── tmux-cht-languages
├── tmux.conf
└── zshrc

Note: The zsh directory contains .zshrc, .zprofile, zshenv, and link-files.sh
