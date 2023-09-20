idletime="cat /proc/uptime | sed 's/ /\n/g' | tail -n 1"
cpucores=$(nproc)

time1=$(sh -c "$idletime")
sleep $1
time2=$(sh -c "$idletime")

timediff=$(echo $time2-$time1 | bc)

echo 1-$(echo $(echo $timediff*$1 | bc -l)/$cpucores | bc -l) | bc -l