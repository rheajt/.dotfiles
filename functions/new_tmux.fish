function new_tmux
    set --local DIR_STEM (basename "$PWD")
    tmux new -s $DIR_STEM
end

