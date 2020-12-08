#!/bin/bash

total=0
while read line ; do
    if [ "$line"  == ""  ] ; then
    ((++i))
    fileName="OutputFile_$i"
    else
    split_input[i]="${split_input[i]} $line"
    fi
    done < input_sample.txt

for i in "${!split_input[@]}"; do
    count=0
    group=${split_input[i]}
    # echo $group
    for x in {a..z}; do

        if [[ $group =~ "$x" ]]; then
            count=$((count+1))
        fi
    done
    total=$((total+count))
done

echo $total