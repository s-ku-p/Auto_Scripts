#!/bin/bash
file=input
oldifs=$IFS
pass_list='pass: '
fail_list='fail: '
while IFS='' read -r line || [[ -n "$line" ]]; do
    capture_out=$(python3 ./test_run.py $line 2>&1)
    echo $capture_out
    count_pass=$(echo $capture_out | grep -c 'PASSED')
    count_fail=$(echo $capture_out | grep -c 'FAILED')
    if [ $count_pass == 1 ]; then
      pass_list="$pass_list $line"
    elif [ $count_fail == 1 ]; then
      fail_list="$fail_list $line"
    else
        echo none
    fi
    echo $line
done < "$file"
echo $pass_list
echo $fail_list
IFS=$oldifs
