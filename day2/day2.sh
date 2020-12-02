#!/bin/bash
valid=0
while read p; do
    match="no"
    IFS=' ' read -r -a array <<< "$p"
    count=${array[0]}
    policy=${array[1]:0:1}
    password=${array[2]}

    # echo "range: $count"
    # echo "policy: $policy"
    # echo "password: $password"
    num=$(echo "${password}" | awk -F ${policy} '{print NF-1}')

    a=${count%-*}
    b=${count#*-}
    # echo $a
    # echo $b

    if [ "$num" -ge "$a" ] && [ "$num" -le "$b" ]; then
        #echo "$password"
        match="yes"
        valid=$((valid+1))
    fi

    #echo "Range: $count Policy: $policy Password: $password Count: ${num} Match: ${match}"


done <input.txt

echo $valid