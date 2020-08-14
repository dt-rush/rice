#!/bin/bash

toptask() {
    cat "$1" | grep -v "\[X\]" | sed -r 's/(\[|\])//g' | sed -r 's/-\s+(.+)/\1/' | head -n 1
}

WIKIROOT=$HOME/vimwiki

MAINTASK=$(toptask $WIKIROOT/Tasks.wiki)
if [ -f "$WIKIROOT/${MAINTASK}.wiki" ]; then
    SUBTASK=$(toptask "$WIKIROOT/${MAINTASK}.wiki")
    echo $MAINTASK "::" $SUBTASK
else
    echo $MAINTASK
fi

