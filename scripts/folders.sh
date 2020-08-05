# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    folders.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: blinnea <blinnea@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/05 19:54:55 by blinnea           #+#    #+#              #
#    Updated: 2020/08/05 19:54:57 by blinnea          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/zsh

mkdir -p /goinfre/$USER
mkdir -p /goinfre/$USER/{Downloads, Screenshots}
mkdir -p /goinfre/$USER/Downloads/{Chrome, Slack, Telegram}
mkdir -p $HOME/Social
ln -sf /Applications/Slack.app $HOME/Social/Slack
ln -sf $HOME/Applications/Telegram.app $HOME/Social/Telegram


