#!/bin/bash

valid=0
while read p; do
    match=0
    IFS=' ' read -r -a array <<< "$p"
    count=${array[0]}
    policy=${array[1]:0:1}
    password=${array[2]}

    num=$(echo "${password}" | awk -F ${policy} '{print NF-1}')

    a=${count%-*}
    b=${count#*-}

    match1=${password:${a}-1:1}
    match2=${password:${b}-1:1}

    if [ $match1 == $policy ]; then
        match=$((match+1))
    fi

    if [ $match2 == $policy ]; then
        match=$((match+1))
    fi

    if [ "$match" -eq "1" ] ; then
        valid=$((valid+1))
    fi

done <input.txt

echo $valid