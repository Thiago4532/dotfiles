## Thiago4532's dotfiles
# Author: Thiago Mota
# Source: https://github.com/Thiago4532/dotfiles

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=500000
SAVEHIST=500000
setopt incappendhistory

# Shell options
setopt autocd
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

# [ -d "$HOME/.zsh-completions" ] &&
#     fpath=($HOME/.zsh-completions $fpath)

autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
# End of lines added by compinstall

autoload -U select-word-style
select-word-style bash

autoload zmv
alias zcp='zmv -C'
alias zln='zmv -L'

# Environment variables
ZLE_RPROMPT_INDENT=0
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Keybindings
bindkey "^[[3~" delete-char # Delete
bindkey "^[[1;5C" forward-word # Ctrl + Right
bindkey "^[[1;5D" backward-word # Ctrl + Left
bindkey "^H" backward-kill-word # Ctrl + Backspace
bindkey "^[[3;5~" kill-word # Ctrl + Delete
bindkey "^A" beginning-of-line
bindkey "^[[H" beginning-of-line
bindkey "^E" end-of-line
bindkey "^[[F" end-of-line
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

source ~/.zplug/init.zsh

# Plugins
# [ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh
[ -f /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found

zplug romkatv/powerlevel10k, as:theme, depth:1 # Powerlevel10k theme
zplug zsh-users/zsh-completions
zplug Aloxaf/fzf-tab
zplug zsh-users/zsh-autosuggestions
zplug zdharma-continuum/fast-syntax-highlighting, defer:2
zplug zsh-users/zsh-history-substring-search
# zplug zsh-users/zsh-syntax-highlighting, defer:2

# Then, source plugins and add commands to $PATH
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Functions
source ~/.zsh_functions

# Aliases
source ~/.zsh_aliases

# Non-public scripts
[ -f ~/.zsh_priv ] && source ~/.zsh_priv

check_exe zoxide && eval "$(zoxide init zsh)"

# Extra completions
compdef _htracker htracker
compdef _man batman

# precmd
precmd () { print -Pn "\e]0;zsh: %~\a" }

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

compdef fake-git=git

# to avoid non-zero status at startup
true
