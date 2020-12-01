#!/bin/bash
input=($(<input.txt))

for i in "${!input[@]}"; do
  #printf '${input[%s]}=%s\n' "$i" "${input[i]}"
  a=${input[i]}
  for j in "${!input[@]}"; do
    b=${input[j]}
    c=$((a + b))
    if [[ $c -eq 2020 ]] ; then
        echo $a
        echo $b
        d=$((a * b))
        echo $d
        exit
    fi
  done
done