#!/usr/bin/env bash

values=$(cat input.txt)

readarray -d $'\n\n' -t my_array<<<"$values"

max1=0
max2=0
max3=0
total=0

for val in "${my_array[@]}"
do
  if [[ $val == "" ]]; then
    if [[ $total -ge $max1 ]]; then
      max3=$max2
      max2=$max1
      max1=$total
    elif [[ $total -ge $max2 ]]; then
      max3=$max2
      max2=$total
    elif [[ $total -ge $max3 ]]; then
      max3=$total
    fi
    total=0
  else
    total=$((total+val))
  fi
done

if [[ $total -gt $max1 ]]; then
  max3=$max2
  max2=$max1
  max1=$total
fi

max_total=$(($max1+$max2+$max3))

echo "Max total is $max_total"
