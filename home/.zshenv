#!/bin/bash

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
alias .....="cd ../../../.."

# workspace jumping
alias wo="cd ~/workspace/"

# some more ls aliases
# alias ls='colorls --light'
alias ls='ls -h --color=always'
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear && ls'
alias cl='clear'
alias lrt='ls -1rt'

# less with colors
alias less='less -r'

# editor
alias rvim='sudo vim'
alias v='vim'

# clipboard piping
alias clip='xclip -i -selection clipboard'

# for god sake stop using swap files please
alias vim='vim -n'

# edit various config files
alias cfc='grep --color=never "alias cf" ~/.bash_aliases | grep -v "alias cfc"'
alias cfi='vim ~/.config/i3/config'
alias cfv='vim ~/.vimrc'
alias cfp='vim ~/.profile'
alias cfbr='vim ~/.bashrc'
alias cfzr='vim ~/.zshrc'
alias szr='source ~/.zshrc'
alias cfa='vim ~/.zshenv' # cfa = "config alias"
alias cfze='vim ~/.zshenv'
alias sza='source ~/.zshenv' # sza = "source alias"
alias sze='source ~/.zshenv'
alias cfs='vim ~/.ssh/config'
alias cfh='sudo vim /etc/hosts'
alias cft='vim ~/.config/terminator/config'
alias cfr='sudo vim /etc/resolv.conf'
alias cfh='vim ~/.hyper.js'

# colors for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$(if [[ $? == 0 ]]; then echo "terminal"; else echo "error"; fi)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'') finished"'

# easy cloning to a directory that preserves github usernames
alias gitclone='source ~/bin/gitclone-source-me'

# virtualenv activate
alias va='source $(find . -path \*bin/activate)'
# virtualenv deactivate
alias vd='deactivate'

# fix merge conflicts
alias fix='git diff --name-only | uniq | xargs vim'

# git aliases of my own (extensions of 'git' plugin)
alias whichgitbranch='git rev-parse --abbrev-ref HEAD'
alias grbom='git rebase origin/master'
alias gpf='git push --force-with-lease'
alias gpfo='git push --force-with-lease origin'
alias gpfo.='git push --force-with-lease origin $(whichgitbranch)'
alias gfagrbomgpfo.='gfa && grbom && gpfo.'
alias gd='git --no-pager diff'

# notebook
alias notebook="mkdir -p ~/Documents/journal/\$(date +"%y"); cd ~/Documents/journal; vim ~/Documents/journal/\$(date +"%y")/\$(date +"%Y%m%d").md"
alias nb="notebook"

# name of current directory as a banner
alias name="basename \$(pwd) | toilet -w 128 -t"

# kubectl
alias k="kubectl"

# k9s noboom
# alias k9s="k9s"
