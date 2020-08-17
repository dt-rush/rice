#!/bin/bash

# 78: Nothing in the world is as soft and yielding as water. Yet for dissolving 
# the hard and inflexible, nothing can surpass it. The soft overcomes the hard; 
# the gentle overcomes the rigid. Everyone knows this is true, but few can put 
# it into practice. Therefore the Master remains serene in the midst of sorrow. 
# Evil cannot enter his heart. Because he has given up helping, he is peoples 
# greatest help. True words seem paradoxical.

gen-alacritty-dark-config
x-terminal-emulator --config-file=$HOME/.config/alacritty/alacritty.yml.dark --title "float-tao" --command bash -c "~/bin/randomtao/random.js && sleep 30"
