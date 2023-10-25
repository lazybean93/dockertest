# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

for i in $(seq 0 10); do
	#--name = generalworker_$i
	#--rm = automatically remove container when exists
	# -i  = keep stdin open
	# -t  = allocate pseudo tty
	# -d  = detach
	# -p  = portmapping
	# dockertest:latest = name
	docker run --name generalworker_$(printf %02d $i) --rm -i -t -d -p $((2200+$i)):22 -p $((7000+$i)):5901/tcp dockertest:latest &
	sleep 0.1
done
#while [ $(echo $(sh "$SCRIPTPATH"/../userfiles/load.sh 1)*100 | bc -l | sed 's/\./\n/g' | head -n1) -lt 10 ]; do
#	date;
#	sleep 1
#done
