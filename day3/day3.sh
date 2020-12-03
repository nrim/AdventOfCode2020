input=($(<input.txt))
length=${#input[@]}
x=0
tree=0
# loop through the input file
for y in "${!input[@]}"; do
  width=${#line}
  line=${input[y]}
  current=${line:x:1}
  nextline=${input[y+1]}

  #handle repeating landscape by reseting x
  x=$((x+3))
  if (( x > width-1 )); then
    x=$((x-width))
  fi



  if [ -z "$nextline" ]; then
    echo "done!"
  else
    next=${nextline:x:1}
    # echo $next
    if [ $next = "#" ]; then
      trees=$((trees+1))
    fi
  fi

done

echo "Trees: $trees"