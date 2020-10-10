# Thiago4532's dotfiles  

Use zsh as default shell.  

Use the follow alias to set up dotfiles.  
```bash
git clone --depth=1 --bare ~/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
```  
Ignore README.md in local repository
```bash
dotfiles config core.sparsecheckout true
```

Install plugins to vim using vim-plug and coc-nvim.
```
:PlugInstall
:CocInstall
```
