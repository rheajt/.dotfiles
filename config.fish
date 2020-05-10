# https://fishshell.com/docs/current/tutorial.html#tutorial

# aliases
alias vim='nvim'

# abbreviations
if status --is-interactive
    abbr --add --global gs 'git status'
    abbr --add --global gc 'git add -A; git commit -am'
    abbr --add --global second 'echo my second abbreviation'
    abbr --add --global tas 'tmux attach-session -t'
    abbr --add --global tds 'tmux detach'
    abbr --add --global tns 'tmux new -s'
end
