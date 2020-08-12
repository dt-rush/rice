#!/bin/bash

# copy fonts dir
header "COPY FONTS"
mkdir -p ~/.local/share/
cp -r ./fonts/ ~/.local/share/
mkfontdir ~/.local/share/fonts
xset +fp ~/.local/share/fonts
xset fp rehash

