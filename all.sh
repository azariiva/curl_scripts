# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    all.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: blinnea <blinnea@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/05 11:44:29 by blinnea           #+#    #+#              #
#    Updated: 2020/08/07 19:36:07 by blinnea          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/zsh

CurlHome="https://raw.githubusercontent.com/azariiva/kushCurl/master"

function EnablePluginsZSH {
	local tag="# Load ZSH Plugins"

	if ! grep -q $tag $HOME/.zshrc
	then
	printf "\n%s\n%s\n" $tag "plugins=(z web-search zsh-autosuggestions colored-man-pages colorize common-aliases copyfile)" >> $HOME/.zshrc
	fi
}

function InstallBrew {
	local IPATH=/goinfre/$USER

	mkdir -p $IPATH
	if ! command -v brew
	then
		# rm -rf $HOME/.brew
		# rm -rf $IPATH/.brew
		git clone --depth=1 https://github.com/Homebrew/brew $IPATH/.brew
		curl -fsSLo $HOME/.brewconfig.zsh $CurlHome/src/brewconfig.zsh
		if ! grep -q "# Load Homebrew config script" $HOME/.zshrc
		then
			printf "%s\n%s\n" "# Load Homebrew config script" "source $IPATH/.brewconfig.zsh"
		fi
		source $HOME/.brewconfig.zsh
		rehash
		brew update
		echo "\nPlease open a new shell to finish installation"
	fi
	/goinfre/blinnea/.brew/bin/brew install python3
	/goinfre/blinnea/.brew/bin/brew install htop
	/goinfre/blinnea/.brew/bin/brew install --HEAD https://raw.githubusercontent.com/LouisBrunner/valgrind-macos/master/valgrind.rb
	/goinfre/blinnea/.brew/bin/brew unlink valgrind & /goinfre/blinnea/.brew/bin/brew link valgrind
	rm -rf $(/goinfre/blinnea/.brew/bin/brew --cache)
}

function WriteAliases {
	if ! grep -q '# My own aliases' $HOME/.zshrc
	then
		curl -fsS $CurlHome/src/brewconfig.zsh >>  $HOME/.zshrc
	fi
}

function InstallTelegram {
	local IPATH=$HOME/Applications
	local DPATH=/tmp/$USER

	if [ ! -d $IPATH/Telegram.app ]
	then
		curl -L https://telegram.org/dl/desktop/mac --output $DPATH/tsetup.dmg
		VOLUME=$(hdiutil attach tsetup.dmg | tail -1 | awk '{$1=$2=""; print $0}' | sed -e 's/^[[:space:]]*//')
		cp -r $VOLUME/*.app $IPATH
		diskutil unmount $VOLUME &>/dev/null
		ln -sf $IPATH/Telegram.app ~/Desktop
		rm -f $DPATH/tsetup.dmg
	fi
}

function CreateLinks {
	ln -sf /Applications/Slack.app $HOME/Social/Slack
	ln -sf $HOME/Applications/Telegram.app $HOME/Social/Telegram
}

function CreateDirectories {
	mkdir -p /goinfre/$USER
	mkdir -p /goinfre/$USER/{Downloads,Screenshots}
	mkdir -p /goinfre/$USER/Downloads/{Chrome,Slack,Telegram}
	mkdir -p $HOME/Social
}

CreateDirectories
EnablePluginsZSH
InstallTelegram
CreateLinks
WriteAliases
EnablePluginsZSH
InstallBrew
