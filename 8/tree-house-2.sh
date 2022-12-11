#!/usr/bin/env bash
# This is broken

file=$(cat input.txt)

readarray -d $'\n' -t lines<<<"$file"

grid=()
for line in "${lines[@]}"
do
  grid+=($line)
done

total=0
grid_len="${#grid[@]}"
for (( r=0; r<"$grid_len"; r++))
do
  line="${grid[$r]}"
  line_len="${#grid[$r]}"
  for (( c=0; c<"${#grid[r]}"; c++))
  do
    L=0
    R=0
    U=0
    D=0
    # Left side check
    k="${line:c:1}"
    c_minus=$((c-1))
    for (( x=c_minus; x>-1; x--))
    do
      L=$((trees+1))
      if [[ "${line:$x:1}" -ge $k ]]; then
        break
      fi
    done

    # Right side check
    next_c=$((c+1))
    for (( x=$next_c; x<"$line_len"; x++))
    do
      R=$((trees+1))
      if [[ "${line:$x:1}" -ge $k ]]; then
        break
      fi
    done

    # Check if there was a bigger one up
    r_minus=$((r-1))
    for (( x=r_minus; x>-1; x--))
    do
      U=$((trees+1))
      column="${grid[$x]}"
      if [[ "${column:$c:1}" -ge $k ]]; then
        break
      fi
    done

    # Check if there was a bigger one down
    next_row=$((r+1))
    for (( x="$next_row"; x<"$grid_len"; x++))
    do
      D=$((trees+1))
      column="${grid[$x]}"
      if [[ "${column:$c:1}" -ge $k ]]; then
        break
      fi
    done

    echo "THIS IS LINE INFO"
    echo "line is $line"
    echo "r is $r"
    echo "C is $c"
    echo "Current is $k"
    echo "L is $L"
    echo "R is $R"
    echo "U is $U"
    echo "D is $D"
    temp=$((L*R*U*D))
    echo "temp is $temp"
    echo ""
    (( total < temp )) && total=$((L*R*U*D))

  done
done

echo "${grid[@]}"
echo "${#grid[@]}"
echo "${#grid[0]}"

echo "$total"
