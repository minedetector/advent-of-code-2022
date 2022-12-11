#!/usr/bin/env bash

values=$(cat input.txt)

readarray -d $'\n' -t input<<<"$values"

declare -A alphabet
count=1
for x in {a..z}
do
  alphabet["$x"]=$count
  count=$((count+1))
done

points=0

for i in "${input[@]}"
do
  echo "$i"
  half="$((${#i} / 2))"
  string_length="${#i}"
  first_half="${i:0:$half}"
  second_half="${i:$half:$string_length}"

  result=$(comm -12 <(fold -w1 <<< "$first_half" | sort -u) <(fold -w1 <<< "$second_half" | sort -u) | tr -d '\n')

  if [[ $result =~ [A-Z] ]]; then
    points=$((points+26))
  fi

  points=$((points+${alphabet[${result,,}]}))
  echo "$result"
done

echo "$points"
