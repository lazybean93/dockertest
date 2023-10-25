# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`
MAX_I=9
for i in $(seq 0 $MAX_I); do
	#--name = generalworker_$i
	#--rm = automatically remove container when exists
	# -i  = keep stdin open
	# -t  = allocate pseudo tty
	# -d  = detach
	# -p  = portmapping
	# dockertest:latest = name
	docker run --name generalworker_$(printf %03d $i) --rm -i -t -d -p $((2200+$i)):22 -p $((7000+$i)):5901/tcp dockertest:latest &
	sleep 0.1
done
for i in $(seq $MAX_I); do
	docker exec generalworker_$(printf %03d $i) sh -c "nmap -sP 192.168.178.1/24 > /home/automate/ip.txt"
done
#while [ $(echo $(sh "$SCRIPTPATH"/../userfiles/load.sh 1)*100 | bc -l | sed 's/\./\n/g' | head -n1) -lt 10 ]; do
#	date;
#	sleep 1
#done
