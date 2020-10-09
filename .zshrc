#!/bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH Completion
zstyle :compinstall filename '/home/thiagomm/.zshrc'
autoload -Uz compinit
compinit

setopt autocd

# ZSH Theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins configuration
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=12"

# History options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY

# ZSH Plugins
source /usr/share/doc/pkgfile/command-not-found.zsh
source ~/.zsh-plugins/zsh-z/zsh-z.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Keybindings
bindkey -e

# Cursor movement
bindkey "^[[D" backward-char
bindkey "^[[C" forward-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Editing

bindkey "^[[3~" delete-char
bindkey "^H" backward-kill-word
bindkey "^[h" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^[d" kill-word
bindkey "^[k" backward-kill-line
bindkey "^K" kill-line
bindkey "^[j" kill-buffer
bindkey "^_" undo
bindkey "^[/" redo

# Aliases
source ~/.zsh_aliases

# Functions

function mkcd() {
	mkdir -p "$1" && cd "$1"
}
compdef _directories mkcd

function pacupd() {
	local packages
	if packages=$(pactree -su "$1"); then
		echo $packages | xargs sudo pacman -Sy --noconfirm --needed
	fi
}
