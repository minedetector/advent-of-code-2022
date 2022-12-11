#!/usr/bin/env bash

# Opponent
# A for Rock
# B for Paper
# C for Scissors

# Me
# X for Rock    | lose
# Y for Paper   | draw
# Z for Scissor | win

values=$(cat input.txt)

readarray -d $'\n' -t game<<<"$values"

i_win=("C Z" "A Z" "B Z")
draw=("A Y" "B Y" "C Y")

points=0

declare -A my_choice
my_choice["C Z"]="X"
my_choice["A Z"]="Y"
my_choice["B Z"]="Z"
my_choice["A Y"]="X"
my_choice["B Y"]="Y"
my_choice["C Y"]="Z"
my_choice["A X"]="Z"
my_choice["B X"]="X"
my_choice["C X"]="Y"

declare -A score
score["Z"]=3
score["Y"]=2
score["X"]=1

choice_points=0
for i in "${game[@]}"
do
  if [[ "${i_win[*]}" =~ $i ]]; then
    points=$((points+6))
  elif [[ "${draw[*]}" =~ $i ]]; then
    points=$((points+3))
  fi

  hand="${my_choice[$i]}"
  choice_points="${score[$hand]}"

  points=$((points+choice_points))
done

echo "$points"


#if [[ "${i_win[0]}" == "$i" ]] || [[ "${i_win[1]}" == "$i" ]] || [[ "${i_win[2]}" == "$i" ]]; then
  #  echo "win"
  #elif [[ "${draw[0]}" == "$i" ]] || [[ "${draw[1]}" == "$i" ]] || [[ "${draw[2]}" == "$i" ]]; then
  #  echo "draw"
  #else
  #  echo "lose"
  #fi
  #case $i in
  #  "${i_win[0]}"|"${i_win[1]}"|"${i_win[2]}")
  #    echo "win"
  #  ;;
  #  "${draw[0]}"|"${draw[1]}"|"${draw[2]}")
  #    echo "draw"
  #  ;;
  #  *)
  #    echo "lost in case"
  #esac
