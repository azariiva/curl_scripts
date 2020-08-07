# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    brew.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: blinnea <blinnea@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/05 11:44:34 by blinnea           #+#    #+#              #
#    Updated: 2020/08/07 13:52:00 by blinnea          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/zsh

# Create installation path
IPATH=/goinfre/$USER/
mkdir -p $IPATH

# Install Brew if It isn't here
if ! command -v brew
then
	# Remove all posible old directories
	rm -rf $HOME/.brew
	rm -rf $IPATH/.brew
	# Clone repositorie from github
	git clone --depth=1 https://github.com/Homebrew/brew $IPATH/.brew
	# Create .brewconfig script in home directory
	cat > $IPATH/.brewconfig.zsh <<EOL
		# HOMEBREW CONFIG

		# Add brew to path
		export PATH=$IPATH/.brew/bin:\$PATH

		# Set Homebrew temporary folders
		export HOMEBREW_CACHE=/tmp/\$USER/Homebrew/Caches
		export HOMEBREW_TEMP=/tmp/\$USER/Homebrew/Temp

		mkdir -p \$HOMEBREW_CACHE
		mkdir -p \$HOMEBREW_TEMP

		# If NFS session
		# Symlink Locks folder in /tmp
		if df -T autofs,nfs \$IPATH 1>/dev/null
		then
		HOMEBREW_LOCKS_TARGET=/tmp/\$HOME/Homebrew/Locks
		HOMEBREW_LOCKS_FOLDER=$IPATH/.brew/var/homebrew

		mkdir -p \$HOMEBREW_LOCKS_TARGET
		mkdir -p \$HOMEBREW_LOCKS_FOLDER

		# Symlink to Locks target folders
		# If not already a symlink
		if ! [[ -L \$HOMEBREW_LOCKS_FOLDER && -d \$HOMEBREW_LOCKS_FOLDER ]]
		then
			echo "Creating symlink for Locks folder"
			rm -rf \$HOMEBREW_LOCKS_FOLDER
			ln -s \$HOMEBREW_LOCKS_TARGET \$HOMEBREW_LOCKS_FOLDER
		fi
		fi
EOL

	# Добавить файл .brewconfig в ваш .zshrc, если он ещё не там
	if ! grep -q "# Load Homebrew config script" $HOME/.zshrc
	then
	cat >> $HOME/.zshrc <<EOL

# Load Homebrew config script
source $IPATH/.brewconfig.zsh
EOL
	fi
	source $IPATH/.brewconfig.zsh
	rehash
	brew update
	echo "\nPlease open a new shell to finish installation"
fi
