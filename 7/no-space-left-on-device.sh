#!/usr/bin/env bash

values=$(cat input.txt)

readarray -d $'\n' -t lines<<<"$values"

declare -A sizes

path=()
for line in "${lines[@]}"
do
  line_array=($line)
  if [[ $line = "$ cd"* ]] ; then
    dir=${line_array[-1]}
    if [[ "$dir" == ".." ]]; then
      unset path[-1]
    else
      path+=($dir)
    fi
  elif [[ $line = "$ ls" ]]; then
    continue
  else
    size=${line_array[0]}
    re='^[0-9]+$'
    if [[ "$size" =~ $re ]] ; then
      path_len=${#path[@]}
      for (( i=0; i<$path_len; i++ ))
      do
        x=$((i+1))
        bar=$(IFS=; echo "${path[*]:0:x}")
        path_string="/$bar"
        current_size=$((sizes[$path_string]+size))

        sizes[$path_string]=$current_size
      done
    fi
  fi
done

ans=0

for i in "${sizes[@]}"
do
  if [[ $i -lt 100000 ]]; then
    ans=$((ans+i))
  fi
done

echo "$ans"

to_free=$((30000000-(70000000-sizes[//])))
echo $to_free
bigger_than_to_free=()
for i in "${sizes[@]}"
do
  if [[ $i -ge $to_free ]]; then
    bigger_than_to_free+=($i)
  fi
done

min=${bigger_than_to_free[0]}

for i in "${bigger_than_to_free[@]}"; do
  (( i < min )) && min=$i
done

echo "minimal value is $min"
