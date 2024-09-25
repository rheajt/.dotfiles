#!/usr/bin/bash

LANGUAGES=~/projects/dotfiles/tmux/tmux-cht-languages
COMMANDS=~/projects/dotfiles/tmux/tmux-cht-command

selected=`cat $LANGUAGES $COMMANDS | fzf`

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query
query=`echo $query | tr ' ' '+'`

if grep -qs "$selected" $LANGUAGES; then
    # tmux splitw -h bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query | batcat --style=plain & while [ : ]; do sleep 1; done"
    bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query | batcat --style=plain & while [ : ]; do sleep 1; done"
else
    # tmux splitw -h bash -c "echo \"curl cht.sh/$selected~$query/\" & curl cht.sh/$selected-$query | batcat --style=plain & while [ : ]; do sleep 1; done"
    bash -c "echo \"curl cht.sh/$selected~$query/\" & curl cht.sh/$selected-$query | batcat --style=plain & while [ : ]; do sleep 1; done"
fi
