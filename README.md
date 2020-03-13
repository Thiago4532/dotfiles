# Thiago4532's dotfiles  

Use zsh as default shell.  

Use the follow alias to set up dotfiles.  
```bash
git init --bare ~/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME
dotfiles config --local status.showUntrackedFiles no
```  
To ignore README.md in local repository
```bash
dotfiles update-index --assume-unchanged Localization/el-GR.js
```

Install plugins to vim using vim-plug.
```
:PlugInstall
```
