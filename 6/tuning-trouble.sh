#!/usr/bin/env bash

values=$(cat input.txt)

string_len="${#values}"

part_1=4
part_2=14

count=$part_1
for (( i=0; i<=string_len; i++))
do
  substring_len=$(echo "${values:$i:$part_1}" | fold -w1 | sort | uniq | wc -l)
  if [[ $substring_len -eq $part_1 ]]; then
    echo "$count"
    break
  fi
  count=$((count+1))
done
