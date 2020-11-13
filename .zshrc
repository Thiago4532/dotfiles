# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt incappendhistory

# Shell options
setopt autocd
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename '/home/thiagomm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Environment variables
export ZLE_RPROMPT_INDENT=0
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"
export ZSH_AUTOSUGGEST_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

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

if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
else
  echo "No fzf keybindings!"
fi

source ~/.zplug/init.zsh

# Plugins
[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh
command -v fasd > /dev/null && source ~/.fasd.zsh

zplug romkatv/powerlevel10k, as:theme, depth:1 # Powerlevel10k theme
zplug zsh-users/zsh-completions
zplug Aloxaf/fzf-tab
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-syntax-highlighting

# Then, source plugins and add commands to $PATH
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
source ~/.zsh_aliases

# Functions
source ~/.zsh_functions
