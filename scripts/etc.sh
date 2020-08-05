# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    etc.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: blinnea <blinnea@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/05 11:44:29 by blinnea           #+#    #+#              #
#    Updated: 2020/08/05 14:46:35 by blinnea          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/zsh

# Install function if it isn't present
function installIfAbsent {
	if [[ -n $1 && -n $2 ]] && ! (( $+commands[$1] ))
	then
		brew install $2 $3
	fi
}

# Check if Homebrew installed
if ! (( $+commands[brew] ))
then
	echo "You need to install Homebrew first!"
	exit
fi

# Install python3, valgrind, htop and curl if necessary
installIfAbsent "python3" "python3" ""
installIfAbsent "curl" "curl" ""
installIfAbsent "htop" "htop" ""
installIfAbsent "valgrind" "--HEAD" "https://raw.githubusercontent.com/LouisBrunner/valgrind-macos/master/valgrind.rb"
rm -rf $(brew --cache)

# Install mysides to edit sidebar of Finder
if ! (( $+commands[mysides]))
then
	git clone https://github.com/mosen/mysides.git /tmp/$USER/mysides
	make build -C /tmp/$USER/mysides
	cp /tmp/$USER/mysides/build/Release/mysides $HOME/bin
fi
