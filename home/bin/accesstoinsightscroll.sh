#!/bin/bash

# text="sphinx of black quartz, judge my vow. the quick brown fox jumps over the lazy dog."

text="$(~/bin/accesstoinsightsample.py) ------------"

zscroll -l 80 -p "☸☸☸☸☸☸☸☸☸☸☸☸☸☸" -d 0.1 -t 300 "$text" &
wait
