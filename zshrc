# If you come from bash you might have to change your $PATH.
export PATH=$HOME/projects/dotfiles/bash-scripts:$HOME/.local/bin:$HOME/.local/sh:/usr/local/bin:$PATH



export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting fzf zsh-vi-mode zsh-autosuggestions)


# load cargo env
source "$HOME/.cargo/env"
# load omz env
source $ZSH/oh-my-zsh.sh

# User configuration
# export PATH=$PATH:/usr/local/go/bin
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export EDITOR="nvim"
export ZVM_VI_EDITOR="nvim"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.local/zsh_history
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export GTK_USE_PORTAL=1
export SNACKS_GHOSTTY=true
export XDG_DESKTOP_PORTAL_DIR=Gnome

# set up the chatgpt secret
export OPENAI_API_KEY=$(gpg -d ~/.config/chatgpt/chatgpt-secret.txt.gpg 2>/dev/null)

export OPENAI_KEY=$(gpg -d ~/.config/chatgpt/chatgpt-secret.txt.gpg 2>/dev/null)

# a bunch of aliases
alias notes="cd ~/Insync/rheajt@gmail.com/drive/notes/ && nvim"
alias v="nvim"
alias bat="batcat"
alias gs="git status"
alias gc="git add -A && git commit -am "
alias gp="git push"
alias dfs="cd ~/projects/dotfiles"
alias sc="source ~/.zshrc"
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

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS="--height 60% --reverse --border --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#4b84db,hl:#4b84db,hl+:#4b84db --preview 'batcat --color=always --style=numbers {}'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --line-range :50 {}'"

export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--height 60% --reverse --border --preview ''"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

####### KEYS ########
setxkbmap -option caps:none
xmodmap -e "keycode 66 = BackSpace"

# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
zvm_after_init_commands+=(zvm_after_init)

# fnm
export PATH="/home/jordanrhea/.local/share/fnm:$PATH"
eval "`fnm env --use-on-cd`"


# bun completions
[ -s "/home/jordanrhea/.bun/_bun" ] && source "/home/jordanrhea/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# pnpm
export PNPM_HOME="/home/jordanrhea/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# system76-power charge thresholds
system76-power charge-thresholds --profile max_lifespan > /dev/null 2>&1

if [[ -d "$HOME/bin" ]]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
export PATH=$PATH:/usr/local/bin
