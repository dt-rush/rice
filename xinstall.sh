#!/bin/bash

header() {
echo -e "\n\n\n\n\n\t\t\t$1\n\n\n\n\n"
}

# copy fonts dir
header "COPY FONTS"
mkdir -p ~/.local/share/
cp -r ./fonts/ ~/.local/share/
mkfontdir ~/.local/share/fonts
xset +fp ~/.local/share/fonts
xset fp rehash

