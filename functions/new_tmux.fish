function new_tmux
    set --local DIR_STEM (basename "$PWD")
    tmux new-session -s $DIR_STEM -n DEV_CONSOLE -d
    tmux new-window -t $DIR_STEM -d -n CODE

    tmux send-keys -t $DIR_STEM:CODE  "nvim"

    if test -f readme.md
        tmux send-keys -t $DIR_STEM:DEV_CONSOLE "bat readme.md"
    else if test -f readme.text
        tmux send-keys -t $DIR_STEM:DEV_CONSOLE "bat readme.txt"
    else if test -f README.md
        tmux send-keys -t $DIR_STEM:DEV_CONSOLE "bat README.md"
    end

    tmux select-window -t $DIR_STEM:DEV_CONSOLE
    tmux -u attach -t $DIR_STEM
end

