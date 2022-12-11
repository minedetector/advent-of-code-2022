#!/usr/bin/env bash

file=$(cat input.txt)

readarray -d $'\n' -t lines<<<"$file"

grid=()
for line in "${lines[@]}"
do
  grid+=($line)
done

bigger_exists="false"
total=0
grid_len="${#grid[@]}"
for (( r=0; r<"$grid_len"; r++))
do
  line="${grid[$r]}"
  line_len="${#grid[$r]}"
  for (( c=0; c<"${#grid[r]}"; c++))
  do
    # Left side check
    k="${line:c:1}"
    for (( x=0; x<"$c"; x++))
    do
      if [[ "${line:$x:1}" -ge $k ]]; then
        bigger_exists="true"
        break
      fi
    done
    # Check if there was a bigger on the left
    if [[ "$bigger_exists" == "true" ]]; then
      bigger_exists="false"
    else
      total=$((total+1))
      continue
    fi

    # Right side check
    next_c=$((c+1))
    for (( x=$next_c; x<"$line_len"; x++))
    do
      if [[ "${line:$x:1}" -ge $k ]]; then
        bigger_exists="true"
        break
      fi
    done

    # Check if there was a bigger on the right
    if [[ "$bigger_exists" == "true" ]]; then
      bigger_exists="false"
    else
      total=$((total+1))
      continue
    fi

    # Check if there was a bigger one up
    for (( x=0; x<"$r"; x++))
    do
      column="${grid[$x]}"
      if [[ "${column:$c:1}" -ge $k ]]; then
        bigger_exists="true"
        break
      fi
    done

    # Check if there was a bigger one up
    if [[ "$bigger_exists" == "true" ]]; then
      bigger_exists="false"
    else
      total=$((total+1))
      continue
    fi

    # Check if there was a bigger one down
    next_row=$((r+1))
    for (( x="$next_row"; x<"$grid_len"; x++))
    do
      column="${grid[$x]}"
      if [[ "${column:$c:1}" -ge $k ]]; then
        bigger_exists="true"
        break
      fi
    done

    # Check if there was a bigger one up
    if [[ "$bigger_exists" == "true" ]]; then
      bigger_exists="false"
    else
      total=$((total+1))
      continue
    fi

  done
done

echo "$total"
