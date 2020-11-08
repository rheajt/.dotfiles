function new_fish_func
    echo $argv
    command touch ~/Projects/dotfiles/functions/$argv.fish
    command ln -s ~/Projects/dotfiles/functions/$argv.fish ~/.config/fish/functions/$argv.fish
end
