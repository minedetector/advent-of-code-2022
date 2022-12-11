#!/usr/bin/env bash

values=$(cat input.txt)

readarray -d $'\n' -t input<<<"$values"

for i in "${input[@]}"
do
  re='^[0-9]+$'
  if [[ "${i: -1}" =~ $re ]] ; then
    max_stacks="${i: -1}"
    break
  fi
done

declare -A alphabet
read_commands="false"
commands=()
contains_letter='^[A-Z]+$'
for i in "${input[@]}"
do
  string_len="${#i}"
  if [[ "$i" == "" ]]; then
    read_commands="true"
  elif [[ "$read_commands" == "true" ]]; then
    commands+=("$i")
  else
    current_stack=1
    letter_placement=1
    while [[ $letter_placement -le $string_len ]]
    do
      if [[ "${i:$letter_placement:1}" =~ $contains_letter ]]; then
        alphabet["$current_stack"]+="${i:letter_placement:1}"
      fi
      current_stack=$((current_stack+1))
      letter_placement=$((letter_placement+4))
    done
  fi
done

for (( i=1; i<=$max_stacks; i++))
do
  alphabet["$i"]=$(echo ${alphabet["$i"]} | rev)
done

for (( x=0; x<${#commands[@]}; x++ ))
do
  command_list=($(echo "${commands[$x]}" | grep -o '[0-9]\+'))
  how_many="${command_list[0]}"
  from="${command_list[1]}"
  to="${command_list[2]}"
  # remove rev to complete part 2
  alphabet["$to"]+="$(echo ${alphabet[$from]: -$how_many} | rev)"
  alphabet["$from"]="$(echo ${alphabet[$from]::-$how_many})"
done

final_word=""
for i in "${alphabet[@]}"
do
  final_word+="${i: -1}"
done

echo $final_word | rev
