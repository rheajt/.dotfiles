# Fish config
# https://fishshell.com/docs/current/tutorial.html#tutorial
fzf_key_bindings

# dangerous specific
set dangerous_colors 000000 333333 666666 ffffff ffff00 ff6600 ff0000 ff0033 3300ff 0000ff 00ffff 00ff00

set -g DISPLAY 0
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

if [ "$LC_TERMINAL" != "iTerm2" ]
    alias fd=fdfind
    alias bat=batcat
    alias open=explorer.exe
end

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
  abbr --add --global tns 'tmux new -s | basename "$PWD"'
  abbr --add --global tl 'tmux ls'
  abbr --add --global tks 'tmux kill-session -t'

  ### folders
  abbr --add --global pj '~/projects'
  abbr --add --global dfs '~/projects/dotfiles'
  abbr --add --global apps '~/projects/apps'
  abbr --add --global blog '~/projects/apps/rheajt.github.io'
  abbr --add --global gas '~/projects/scripts'
  abbr --add --global sp '~/projects/sharepoint'

  abbr --add --global share '~/projects/sharepoint'
  abbr --add --global onedrive 'cd "~/OneDrive - Keystone Academy"'

  abbr --add --global nff "new_fish_func"
  abbr --add --global sgp "setup_gas_project"

  ### vim the dotfiles
  abbr --add --global vdfs 'nvim ~/projects/dotfiles'

  ## helpers
  abbr --add --global v 'nvim'
  abbr --add --global l 'lvim'
  #abbr --add --global bat 'batcat'
  abbr --add --global sc 'source ~/.config/fish/config.fish'
end

function batclip
  cat $argv | win32yank.exe
  batcat $argv
end

function fish_user_key_bindings
  bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
end

#eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv) 
