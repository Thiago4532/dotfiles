export EDITOR=nvim || export EDITOR=vim
#export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel ${_JAVA_OPTIONS}"
export PATH=$PATH:$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.npm/bin
export GTK_USE_PORTAL="1"

export GOPATH=~/.local/gopath
export PATH=$PATH:$HOME/.local/gopath/bin

export QT_QPA_PLATFORMTHEME=qt5ct

[ -f "$HOME/.tm/_load-path.sh" ] &&
    source "$HOME/.tm/_load-path.sh"

# if [ -z "$SSH_AUTH_SOCK" ] ; then
# 	eval `ssh-agent -s`
# fi
