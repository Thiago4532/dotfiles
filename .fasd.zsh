# fasd in zsh

eval "$(fasd --init posix-alias zsh-ccomp zsh-ccomp-install)"

_fasd_preexec() {
    { eval "fasd --proc \$(fasd --sanitize \$2)" 2>/dev/null; } &|
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec

# fasd aliases

alias v='fasd -f -e nvim'
alias vv='fasd -a -e nvim'
alias o='fasd -a -e xdg-open'
alias oo='fasd -a -i -e xdg-open'
