function dotfiles-add() {
    local tracked_folders=(
        "$HOME/.bin"
        "$HOME/.config/conky"
        "$HOME/.config/dunst"
        "$HOME/.config/kitty"
        "$HOME/.config/nvim"
        "$HOME/.config/picom"
        "$HOME/.config/rofi"
        "$HOME/.config/thmm"
        "$HOME/.config/xmobar"
        "$HOME/.config/xsettingsd"
        "$HOME/.github"
        "$HOME/.xmonad"
        "$HOME/.zsh-completions"
    )
    /usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME add "${tracked_folders[@]}"
    /usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME add -u
}
