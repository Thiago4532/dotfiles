export EDITOR=nvim
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel ${_JAVA_OPTIONS}"
export PATH=$PATH:/home/thiagomm/.local/bin
export GTK_USE_PORTAL="1"

if [ -z "$SSH_AUTH_SOCK" ] ; then
	eval `ssh-agent -s`
fi
