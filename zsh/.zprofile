# ~/.zprofile: executed for login shells.

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
