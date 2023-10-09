#Measuring command
idletime="cat /proc/uptime"
#Filter command
filter="sed 's/ /\n/g' | tail -n 1"
#CPU Cores count
cpucores=$(nproc)

#Measuring
time1="$($idletime)"
sleep $1
time2="$($idletime)"

#Filter
time1_u="$(echo $time1 | sed 's/ /\n/g' | head -n 1)"
time1_i="$(echo $time1 | sed 's/ /\n/g' | tail -n 1)"
time2_u="$(echo $time2 | sed 's/ /\n/g' | head -n 1)"
time2_i="$(echo $time2 | sed 's/ /\n/g' | tail -n 1)"

#Calculating and normalizing difference
diff_u=$(echo $time2_u-$time1_u | bc)
diff_i=$(echo $time2_i-$time1_i | bc)
#echo $diff_u $diff_i
diff_by_time=$(echo $diff_i/$diff_u | bc -l)
#echo 1 $diff_by_time
diff_by_cores=$(echo $diff_by_time/$cpucores | bc -l)
#echo 1 $diff_by_cores
load=$(echo 1-$diff_by_cores | bc -l | sed 's/^\./0\./g')

#Print
echo $load
