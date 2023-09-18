MAX=65535
RANDOM=$(printf "%d\n" 0x$(head --bytes 2 /dev/random | xxd | sed 's/  /\n/g' | head -n1 | sed 's/ //g;s/:/\n/g' | tail -n1))
echo "0""$(echo "scale=3; $RANDOM"/"$MAX" | bc -l)" | sed 's/^00/0/g;s/^01/1/g'