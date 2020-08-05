#!/bin/zsh

# Installation path
IPATH=$HOME/Applications

# Download path
DPATH=/tmp/$USER

# Installs Telegram if it is not in installation directory
if [ ! -d $IPATH/Telegram.app ]
then
	curl -L https://telegram.org/dl/desktop/mac --output $DPATH/tsetup.dmg
	VOLUME=$(hdiutil attach tsetup.dmg | tail -1 | awk '{$1=$2=""; print $0}' | sed -e 's/^[[:space:]]*//')
	cp -r $VOLUME/*.app $IPATH
	diskutil unmount $VOLUME &>/dev/null
	ln -sf $IPATH/Telegram.app ~/Desktop
	rm -f $DPATH/tsetup.dmg
	if ! grep -q "# Set telegram alias" $HOME/.zshrc
	then
		cat >> $HOME/.zshrc <<EOL
# Set telegram alias
alias telegram="open $HOME/Applications/Telegram.app"
EOL
	fi
	echo "Now telegram is installed to $IPATH"
else
	echo "Telegram is already installed to $IPATH"
fi
