#!/bin/zsh

SCR_LOC=https://raw.githubusercontent.com/azariiva/kushCurl/master/scripts
zsh <(curl -fsSL $SCR_LOC/brew.sh)
zsh <(curl -fsSl $SCR_LOC/etc.sh)
zsh <(curl -fsSl $SCR_LOC/telegram.sh)
