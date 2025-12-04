# If you come from bash you might have to change your $PATH.

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic" # set by `omz`

plugins=(
    git 
    fzf 
    zsh-vi-mode 
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# load cargo env
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# load omz env
source $ZSH/oh-my-zsh.sh
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# a bunch of aliases
alias pscli="~/projects/powerschool/pscli/bin/dev.js"
alias notes="cd ~/Insync/rheajt@gmail.com/drive/notes/ && nvim"
alias v="nvim"
alias bat="batcat"
alias gs="git status"
alias gc="git add -A && git commit -am "
alias gp="git push"
alias dfs="cd ~/projects/dotfiles"
alias sc="source ~/.config/zsh/.zshrc"
alias tns="new-tmux-session"
alias tks="tmux kill-session"
alias tl="tmux ls"
alias tas="tmux attach-session -t"
alias tds="tmux detach"
alias blog="cd ~/projects/blog"
alias s="sessions"
alias wttr='curl "wttr.in/$(echo "Sanur\nDenpasar\nBeijing\nRichmond" | fzf)?m&lang=en" | head -n -1'
alias pjs=". projects"
alias :q="exit"

# vim bind
# bindkey -v
fpath+=${ZDOTDIR:-~}/.zsh_functions


####### KEYS ########
# setxkbmap -option caps:none
xmodmap -e "keycode 66 = BackSpace"

# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
zvm_after_init_commands+=(zvm_after_init)
# source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

load_openai_keys() {
  # Only decrypt if not already set
  if [[ -z "$OPENAI_API_KEY" ]]; then
    OPENAI_API_KEY="$(gpg --quiet --decrypt ~/.config/chatgpt/chatgpt-secret.txt.gpg)"
    # if gpg fails, don't clobber with empty
    if [[ -n "$OPENAI_API_KEY" ]]; then
      export OPENAI_API_KEY
      export OPENAI_KEY="$OPENAI_API_KEY"
    fi
  fi
}
