# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting fzf zsh-vi-mode zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$PATH:/usr/local/go/bin
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export EDITOR="nvim"
export ZVM_VI_EDITOR="nvim"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.local/zsh_history
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

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

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim bind
# bindkey -v
fpath+=${ZDOTDIR:-~}/.zsh_functions

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--height 60% --reverse --border --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#4b84db,hl:#4b84db,hl+:#4b84db'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --line-range :50 {}'"

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
eval "`fnm env`"

