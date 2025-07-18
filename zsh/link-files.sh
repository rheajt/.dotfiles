#!/bin/zsh

# This script creates symbolic links for configuration files in the home directory.
# It checks if the target file already exists and prompts the user for confirmation before overwriting.
# Usage: ./link-files.sh
#
# link the zshenv to the ~ directory
ln -sf ~/.config/zsh/zshenv ~/.zshenv

# check and see if the ~/.config/zsh directory exists
if [ ! -d ~/.config/zsh ]; then
    echo "Linking ~/.config/zsh directory..."
    # link this directory to the ~/.config/zsh directory
    ln -sf "$(pwd)" ~/.config/zsh
fi



# Define an array of files to link
files=(
    "zshrc"
    "zprofile"
)

# link each file in the array to a hidden version of the file in the current directory
for file in "${files[@]}"; do
    target="$(pwd)/zsh/.$file"
    source="$(pwd)/zsh/$file"

    # Check if the target file already exists
    if [ -e "$target" ]; then
        echo "File $target already exists."
        read -p "Do you want to overwrite it? (y/n): " choice
        if [[ "$choice" != [Yy]* ]]; then
            echo "Skipping $target."
            continue
        fi
    fi

    # Create the symbolic link
    ln -sf "$source" "$target"
    echo "Linked $source to $target."
done
