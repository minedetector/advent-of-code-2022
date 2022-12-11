#!/usr/bin/env bash

# Opponent
# A for Rock
# B for Paper
# C for Scissors

# Me
# X for Rock
# Y for Paper
# Z for Scissors

values=$(cat input.txt)

readarray -d $'\n' -t game<<<"$values"

i_win=("C X" "A Y" "B Z")
draw=("A X" "B Y" "C Z")
points=0

for i in "${game[@]}"
do
  echo "$i"

  if [[ "${i_win[*]}" =~ $i ]]; then
    echo "winning"
    points=$((points+6))
  elif [[ "${draw[*]}" =~ $i ]]; then
    echo "draw"
    points=$((points+3))
  else
    echo "lose"
  fi

  case "$i" in
    *"Z")
      points=$((points+3))
      ;;
    *"Y")
      points=$((points+2))
      ;;
    *"X")
      points=$((points+1))
      ;;
  esac
done

echo "$points"
