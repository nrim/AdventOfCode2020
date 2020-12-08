#!/bin/bash

declare {a..z}=-1
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
        echo ${!x}
        if [[ $group =~ "$x" ]]; then
            if [[ ${!x} = -1 ]]; then

            fi
            count=$((count+1))
        else ${!x}=0
        fi
    done
    total=$((total+count))
done

echo $total