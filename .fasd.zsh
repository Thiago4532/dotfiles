# fasd in zsh

eval "$(fasd --init posix-alias zsh-ccomp zsh-ccomp-install)"

_fasd_preexec() {
    { eval "fasd --proc \$(fasd --sanitize \$2)"; } &|
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec

# fasd aliases

alias v='fasd -e nvim'
alias vv='fasd -i -e nvim'
alias o='fasd -e xdg-open'
alias oo='fasd -i -e xdg-open'
