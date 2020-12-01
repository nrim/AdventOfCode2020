#!/bin/bash
input=($(<input.txt))

for i in "${!input[@]}"; do
  #printf '${input[%s]}=%s\n' "$i" "${input[i]}"
  a=${input[i]}
  for j in "${!input[@]}"; do
    b=${input[j]}
    for k in "${!input[@]}"; do
      c=${input[k]}
      d=$((a + b + c))
      if [[ $d -eq 2020 ]] ; then
          echo $a
          echo $b
          echo $c
          e=$((a * b * c))
          echo $e
          exit
      fi
    done
  done
done