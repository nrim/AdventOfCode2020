input=($(<input.txt))
length=${#input[@]}

trees=0

# arrays for the slopes
x_array=(1 3 5 7 1)
y_array=(1 1 1 1 2)

# loop through each slope
for i in "${!x_array[@]}"; do
  x_position=0
  x_slope=${x_array[i]}
  y_slope=${y_array[i]}

  slope_trees=0

  echo "Slope: $x_slope $y_slope"

  # loop through the input file
  for y_position in "${!input[@]}"; do
    # skip line(s) in input based on the y_slope
    if [ $((y_position%y_slope)) -eq 0 ]; then
      line=${input[y_position]}
      width=${#line}
      x_position=$((x_position+x_slope))
      nextline=${input[y_position+y_slope]}

      #handle repeating landscape by reseting x
      if (( x_position > width-1 )); then
        x_position=$((x_position-width))
      fi

      if [ "$nextline" ]; then
        next=${nextline:x_position:1}
        if [ $next = "#" ]; then
          slope_trees=$((slope_trees+1))
        fi
      fi
    fi

  done

  echo "Slope_trees for $x_slope and $y_slope: $slope_trees"
  if [ "$trees" == 0 ]; then
    echo "set trees to slope_trees"
    trees=$slope_trees
  else
    echo "multiple trees and slope_trees"
    trees=$((trees*slope_trees))
  fi
done

echo "Trees: $trees"