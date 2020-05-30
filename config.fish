# https://fishshell.com/docs/current/tutorial.html#tutorial
nvm use default

set -g theme_display_vi yes
set -g theme_display_date no
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_color_scheme gruvbox

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
  abbr --add --global dfs '~/Projects/.dotfiles'
  abbr --add --global gas '~/Projects/scripts'
  abbr --add --global apps '~/Projects/apps'

  ### vim the dotfiles
  abbr --add --global vdfs 'vim ~/Projects/.dotfiles'

  ## expressvpn
  abbr --add --global xc 'expressvpn connect'
  abbr --add --global xs 'expressvpn status'
  abbr --add --global xr 'expressvpn disconnect; expressvpn connect'

end
