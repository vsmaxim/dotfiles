# Start x 
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi

export PATH=~/.local/bin:$PATH
export EDITOR=nvim


# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nomatch notify
unsetopt autocd beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vsmaxim/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# ZInit for zsh plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship
# https://github.com/starship/starship/issues/560
precmd() { precmd() { echo "" } }
alias clear="precmd() { precmd() { echo } } && clear"

# # NVM configuration
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript pnpm turbo
zinit snippet OMZ::plugins/nvm/nvm.plugin.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# k8s-handle completion
eval "$(_K8S_HANDLE_COMPLETE=zsh_source k8s-handle)"

# kubectl editor
export KUBE_EDITOR=nvim

# aliases
alias l="ls"
alias ll="ls -lah"
alias llt="ls -laht"
alias cdh="cd ~"
alias cdc="cd ~/dotfiles"
alias cdp="cd ~/Projects"
alias n="nvim ."
alias va="source .venv/bin/activate"
alias vd="deactivate"

