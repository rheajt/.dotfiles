# https://fishshell.com/docs/current/tutorial.html#tutorial
#nvm use default
echo "Using NodeJS " & node -v

#set -g LC_CTYPE en_US.UTF-8
#set -g LC_ALL en_US.UTF-8

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

set -g EDITOR 'nvim'

fish_add_path /usr/local/go/bin

alias fd=fdfind
alias bat=batcat
alias open=explorer.exe

# abbreviations
if status --is-interactive
  ### git commands
  abbr --add --global gs 'git status'
  abbr --add --global gc 'git add -A; git commit -am'
  abbr --add --global gp 'git push'
  abbr --add --global gb 'git checkout -b'
  abbr --add --global gm 'git merge'

  ### tmux abbreviations
  abbr --add --global tas 'tmux attach-session -t'
  abbr --add --global tds 'tmux detach'
  abbr --add --global tns 'tmux new -s'

  ### folders
  abbr --add --global dfs '~/Projects/dotfiles'
  abbr --add --global apps '~/Projects/apps'
  abbr --add --global teams '~/Projects/teams'
  abbr --add --global onedrive 'cd "~/OneDrive - Keystone Academy"'

  abbr --add --global nff "new_fish_func"
  abbr --add --global sgp "setup_gas_project"

  ### vim the dotfiles
  abbr --add --global vdfs 'nvim ~/Projects/dotfiles'

  ## helpers
  abbr --add --global v 'nvim'
  #abbr --add --global bat 'batcat'
  abbr --add --global sc 'source ~/.config/fish/config.fish'

  abbr --add --global nus 'nvm use sp-dev'
end

function batclip
  cat $argv | xclip.exe
  batcat $argv
end

function fish_user_key_bindings
  bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
end

#eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv) 
