function new_tmux
    set --local DIR_STEM (basename "$PWD")
    tmux new-session -s $DIR_STEM -n DEV_CONSOLE -d
    tmux new-window -t $DIR_STEM -d -n CODE

    tmux select-window -t $DIR_STEM:DEV_CONSOLE
    tmux -u attach -t $DIR_STEM
end

