#!/bin/bash

#input=($(<input_sample.txt))

#!/bin/bash
valid_records=0
split_input=()
i=0
fields=(ecl pid eyr hcl byr iyr cid hgt)

while read line ; do 
    if [ "$line"  == ""  ] ; then
    ((++i))
    fileName="OutputFile_$i"
    else
    split_input[i]="${split_input[i]} $line"
    fi
    done < input.txt

# loop through entry
for i in "${!split_input[@]}"; do
    valid_fields=0
    no_cid=0
    record=${split_input[i]}
    
    for j in "${!fields[@]}"; do
        field=${fields[j]}
        if [[ $record = *${field}* ]]; then
            valid_fields=$((valid_fields+1))
        elif [[ $field = "cid" ]]; then
            no_cid=1

        fi
    done
    if [ $(($valid_fields)) -eq 8 ]; then
        valid_records=$((valid_records+1))
    elif [ $(($valid_fields)) -eq 7 ] && [ $(($no_cid)) -eq 1 ]; then
        valid_records=$((valid_records+1))
    fi
done

echo $valid_records