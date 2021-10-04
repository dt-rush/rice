#
#
#
#    PART 1/2: SHELL CONFIG
#
#
#
#

export PATH=$PATH:$HOME/bin

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git lol colored-man-pages shrink-path zsh-autosuggestions auto-ls zsh-completions kubectl)
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# User configuration
AUTO_LS_COMMANDS=(ls)
AUTO_LS_NEWLINE=false

bindkey '^@' autosuggest-accept

setopt AUTO_PUSHD
dirForward () {
    cd +1
    zle reset-prompt
}
zle -N dir-forward dirForward
dirBackward () {
    popd
    zle reset-prompt
}
dirUp () {
    cd ..
    zle reset-prompt
}
zle -N dir-forward dirForward
zle -N dir-backward dirBackward
zle -N dir-up dirUp
bindkey '^[[1;7D' dir-forward
bindkey '^[[1;7C' dir-backward
bindkey '^[[1;7A' dir-up

autoload -U compinit && compinit -u

# autojump
. /usr/share/autojump/autojump.sh

# proper fg
fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

function cls_name() {
    cls && name
    zle reset-prompt
}
zle -N cls_name
# bindkey '^L' cls_name

# cscope db
CSCOPE_DB=~/.cscope.db

# quiet ssh-agent
# credit to: https://yashagarwal.in/posts/2017/12/setting-up-ssh-agent-in-i3/
if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        eval `ssh-agent > ~/.ssh/agent.env`
        ssh-add &> ~/.ssh/ssh-add.log
    fi
else
    eval `ssh-agent > ~/.ssh/agent.env`
    ssh-add &> ~/.ssh/ssh-add.log
fi

# source bash completions
if [ "$(ls -A ~/.bash_completion.d)" ]; then
    source $HOME/.bash_completion.d/*
fi

# source alias file
source ~/.zshenv




#
#
#
#    PART 2/2: MISC CONFIGURE (mainly path stuff)
#
#
#
#

# go
export GOROOT=/usr/local/go/
export PATH=$PATH:$GOROOT/bin
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export path to cache for other programs (like dmenu) which want this path but don't want to run all of .zshrc
echo "$PATH" > /tmp/ZSH_PATH_CACHE

# rust
export PATH=$PATH:$HOME/.cargo/bin

if [[ "$SSH_AUTH_SOCK" = "" ]]; then
    eval `ssh-agent`
fi
ssh-add ~/.ssh/id_rsa 2> /dev/null
