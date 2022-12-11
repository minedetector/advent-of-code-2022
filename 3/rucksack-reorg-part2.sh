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

declare -A three_words

max3=0
for i in "${input[@]}"
do
  three_words["$max3"]="$i"
  if [[ "$max3" -ge 2 ]]; then
    first_two=$(comm -12 <(fold -w1 <<< "${three_words["0"]}" | sort -u) <(fold -w1 <<< "${three_words["1"]}"  | sort -u) | tr -d '\n')

    result=$(comm -12 <(fold -w1 <<< "$first_two" | sort -u) <(fold -w1 <<< "${three_words["2"]}"  | sort -u) | tr -d '\n')

    if [[ $result =~ [A-Z] ]]; then
      points=$((points+26))
    fi
    points=$((points+${alphabet[${result,,}]}))
    max3=0
  else
    max3=$((max3+1))
  fi
done

echo "$points"
