#!/bin/bash

input=($(<input.txt))
high_seat=0

# loop through entry
for i in "${!input[@]}"; do
    max_row=127
    min_row=0
    max_seat=7
    min_seat=0
    seat=0
    row=0
    seatID=${input[i]}
    rowID=${input[i]:0:7}
    seatID=${input[i]:7:3}

    # echo ${input[i]}
    # echo $rowID
    # echo $seatID

    # get row
    for (( i=0; i<${#rowID}; i++ )); do
        if [ $i -lt 6 ]; then
            # echo "$i ${rowID:$i:1}"
            if [ ${rowID:$i:1} = "F" ]; then
                max_row=$(( max_row - (max_row-min_row+1)/2 ))
            else
                min_row=$(( min_row + (max_row-min_row+1)/2 ))
            fi
            # echo "max: $max_row min: $min_row"
        else
            if [ ${rowID:$i:1} = "F" ]; then
                row=$min_row
            else
                row=$max_row
            fi
            # echo "row: $row"
        fi
    done


    # get seat
    for (( i=0; i<${#seatID}; i++ )); do
        if [ $i -lt 2 ]; then
            # echo "$i ${seatID:$i:1}"
            if [ ${seatID:$i:1} = "L" ]; then
                max_seat=$(( max_seat - (max_seat-min_seat+1)/2 ))
            else
                min_seat=$(( min_seat + (max_seat-min_seat+1)/2 ))
            fi
            # echo "max: $max_seat min: $min_seat"
        else
            if [ ${seatID:$i:1} = "L" ]; then
                seat=$min_seat
            else
                seat=$max_seat
            fi
            # echo "seat: $seat"
        fi
    done

    current=$(( row * 8 + seat ))
    echo "current: $current high: $high_seat"
    if [ $current -gt $high_seat ]; then
        high_seat=$current
    fi
done
echo "high: $high_seat"