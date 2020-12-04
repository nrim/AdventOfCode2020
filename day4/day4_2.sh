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

:> line_output.txt

# loop through entry
for i in "${!split_input[@]}"; do
    byr=0
    iyr=0
    eyr=0
    hgt=0
    hcl=0
    ecl=0
    pid=0
    cid=1
    ecl_allowed=(amb blu brn gry grn hzl oth)
    valid_fields=0

    record=(${split_input[i]})
    echo ${split_input[i]} >> line_output.txt
    if [ "$split_input[i]" != "" ] ; then

        for j in "${!record[@]}"; do
            field=${record[j]%%:*}
            value=${record[j]##*:}
            case $field in

            byr)
                if [[ $value -le 2002 ]] && [[ $value -ge 1920 ]]; then
                    byr=1
                fi
                ;;

            iyr)
                if [[ $value -le 2020 ]] && [[ $value -ge 2010 ]]; then
                    iyr=1
                fi
                ;;

            eyr)
                if [[ $value -le 2030 ]] && [[ $value -ge 2020 ]]; then
                    eyr=1
                fi
                ;;

            hgt)
                if [[ $value = *in* ]];  then
                    num=${value/in/}
                    if [[ $num -le 76 ]] && [[ $num -ge 59 ]]; then
                        hgt=1
                    fi
                elif [[ $value = *cm* ]];  then
                    num=${value/cm/}
                    if [[ $num -le 193 ]] && [[ $num -ge 150 ]]; then
                        hgt=1
                    fi
                fi
                ;;

            hcl)
                pattern='^#([a-f0-9]){6}'
                if [[ $value =~ $pattern ]]; then
                    hcl=1
                fi
                ;;

            ecl)
                if [[ " ${ecl_allowed[@]} " =~ " ${value} " ]]; then
                    ecl=1
                fi
                ;;

            pid)
                pattern='^([0-9]){9}'
                if [[ $value =~ $pattern ]]; then
                    pid=1
                fi
                ;;

            cid)
                cid=1
                ;;

            *)
                echo "invalid"
                ;;
            esac


        done

        valid_fields=$((byr+iyr+eyr+hgt+hcl+ecl+pid+cid))
        echo "$byr $iyr $eyr $hgt $hcl $ecl $pid $cid"

        if [ $(($valid_fields)) -eq 8 ]; then
            valid_records=$((valid_records+1))
        fi
    fi
done

echo $valid_records