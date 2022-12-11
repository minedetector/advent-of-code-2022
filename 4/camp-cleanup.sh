#!/usr/bin/env bash

#esimene number on suurem võrdne ja teine väiksem võrdne teisest paarist
#kõik esimesed numbrid on olemas teises funktsioonis

values=$(cat input.txt)

readarray -d $'\n' -t input<<<"$values"

count=0
for i in "${input[@]}"
do
  # part 1
  readarray -d $',' -t line<<<"$i"
  first="${line[0]}"
  second="${line[1]}"

  readarray -d $'-' -t first_list<<<"$first"
  readarray -d $'-' -t second_list<<<"$second"
  first_nr_1="${first_list[0]}"
  first_nr_2="${first_list[1]}"
  second_nr_1="${second_list[0]}"
  second_nr_2="${second_list[1]}"
  if [[ first_nr_1 -ge second_nr_1 ]] && [[ first_nr_2 -le second_nr_2 ]]; then
    count=$((count+1))
  elif [[ second_nr_1 -ge first_nr_1 ]] && [[ second_nr_2 -le first_nr_2 ]]; then
    count=$((count+1))
  fi

  # part 2
  first_numbers=()
  second_numbers=()
  for ((z=first_nr_1; z <= first_nr_2; z++))
  do
    first_numbers+=("$z")
  done
  for ((y=second_nr_1; y <= second_nr_2; y++))
  do
    second_numbers+=("$y")
  done
  first_size="${#first_numbers[@]}"
  second_size="${#second_numbers[@]}"
  sizes=$((first_size+second_size))
  compare=$(echo "${first_numbers[@]}" "${second_numbers[@]}" | tr ' ' '\n' | sort | uniq -u | wc -l | sed -e 's/^[[:space:]]*//')

  if [[ "$compare" -lt "$sizes" ]]; then
    count=$((count+1))
  fi
done

echo "$count"
