#!/bin/bash

while true; do
  CPU_LAST_TWO_SECONDS=$(sar -u 2 1 | tail -n 1 | awk '{print $8}' | perl -nle 'printf "%1.2f\n", 100 - $_;')
  echo $CPU_LAST_TWO_SECONDS > ~/.cpu_last_two_seconds
done
