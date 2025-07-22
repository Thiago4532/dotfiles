# Thiago4532's dotfiles  

Using symlink to manage dotfiles.

> TODO: This README.md is outdated, basically all information here is wrong.

### Cloning

Clone the repository using `--bare` option:
```bash
git clone https://github.com/Thiago4532/dotfiles --depth=1 --bare ~/.dotfiles
```

Configure git to show only tracked files and checkout files:
```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME' # Dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles update --init
dotfiles checkout --force
```

### ZSH

Install [zplug](https://github.com/zplug/zplug) to manage zsh plugins:
```sh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```

After that, run `zplug install` to install all zsh plugins.

> TODO: I am currently using lazy.nvim

### Neovim
Install [packer.nvim](https://github.com/wbthomason/packer.nvim):
```sh
# Unix instructions
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

After installing packer.nvim, run this command to install all the NeoVim plugins:
```lua
:lua require'plugins'.install()
```

Now, you must run this command to install all [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) parsers:
```vim
:TSInstall all
```
