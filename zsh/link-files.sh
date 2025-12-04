#!/bin/zsh

# This script creates symbolic links for zsh configuration files.
# It links the zsh directory from this repo to ~/.config/zsh
# and ensures ~/.zshenv points to the zshenv file in the config directory.
#
# Usage: Run this script from within the zsh directory of the dotfiles repo
#        cd /path/to/dotfiles/zsh && ./link-files.sh

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create ~/.config if it doesn't exist
mkdir -p ~/.config

# Check if ~/.config/zsh already exists and is not a symlink
if [ -e ~/.config/zsh ] && [ ! -L ~/.config/zsh ]; then
    echo "Warning: ~/.config/zsh already exists and is not a symbolic link."
    read -p "Do you want to remove it and create a symbolic link? (y/n): " choice
    if [[ "$choice" != [Yy]* ]]; then
        echo "Skipping ~/.config/zsh linking."
        exit 1
    fi
    rm -rf ~/.config/zsh
fi

# Link the zsh directory to ~/.config/zsh
echo "Linking $SCRIPT_DIR to ~/.config/zsh..."
ln -sf "$SCRIPT_DIR" ~/.config/zsh

# Link zshenv to home directory
echo "Linking ~/.config/zsh/zshenv to ~/.zshenv..."
ln -sf ~/.config/zsh/zshenv ~/.zshenv

echo ""
echo "Zsh configuration linked successfully!"
echo "~/.zshenv -> ~/.config/zsh/zshenv"
echo "~/.config/zsh -> $SCRIPT_DIR"
echo ""
echo "The following files will be loaded by zsh:"
echo "  - ~/.zshenv (always loaded, sets ZDOTDIR)"
echo "  - ~/.config/zsh/.zshrc (interactive shells)"
echo "  - ~/.config/zsh/.zprofile (login shells)"
