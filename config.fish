# https://fishshell.com/docs/current/tutorial.html#tutorial

# aliases
alias vim='nvim'

# abbreviations
if status --is-interactive
  ### git commands
  abbr --add --global gs 'git status'
  abbr --add --global gc 'git add -A; git commit -am'

  ### tmux abbreviations
  abbr --add --global tas 'tmux attach-session -t'
  abbr --add --global tds 'tmux detach'
  abbr --add --global tns 'tmux new -s'

  ### folders
  abbr --add --global dfs '~/projects/.dotfiles'
  abbr --add --global gas '~/projects/scripts'
  abbr --add --global apps '~/projects/apps'

  ### vim the dotfiles
  abbr --add --global vdfs 'vim ~/projects/.dotfiles'
end
