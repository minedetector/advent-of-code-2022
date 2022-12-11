#!/usr/bin/env bash

file=$(cat input.txt)

readarray -d $'\n' -t lines<<<"$file"

x=1

values=(1)
for line in "${lines[@]}"
do
  readarray -d $' ' -t command<<<"$line"
  nr="${command[1]}"
  values+=(${values[-1]})
  if [[ "${command[0]}" == "addx" ]]; then
    previous="${values[-1]}"
    values+=( $((nr+previous)) )
  fi
done

# Part 1
total=0
for x in {20..259..40}
do
  correct_value=${values[ $((x-1)) ]}
  total=$((total+x*correct_value))
done
echo "Total is $total"

# Part 2
for i in $( eval echo {0..${#values[@]}..40} )
do
  for j in {0..40}
  do
    sum=$((values[ $((i+j)) ]-j))
    if [[ "${sum#-}" -le 1 ]]; then
      echo -n "#"
    else
      echo -n " "
    fi
  done
  echo ""
done
