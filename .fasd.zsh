# fasd in zsh

eval "$(fasd --init posix-alias zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

_fasd_preexec() {
    { eval "fasd --proc \$(fasd --sanitize \$2)"; } &|
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec
