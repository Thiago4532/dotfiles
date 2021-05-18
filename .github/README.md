# Thiago4532's dotfiles  

Using git bare to manage dotfiles.

### Cloning

Clone the repository using `--bare` option:
```bash
git clone https://github.com/Thiago4532/dotfiles --depth=1 --bare ~/.dotfiles
```

Configure git to show only tracked files and checkout files:
```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME' # Dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout --force
```

### Zsh dotfiles

Install zplug to manage zsh plugins:
```zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```

After that, run `zplug install` to install all zsh plugins.

### Neovim dotfiles

Install plugins to nvim using vim-plug.
```
:PlugInstall
```

Restart neovim to install coc-nvim plugins.
