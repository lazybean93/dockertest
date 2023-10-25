# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`
Count=10
MAX_I=$(($Count-1))
NAME="generalworker_"
FILE="/home/automate/id.txt"

cd "$SCRIPTPATH""/.."

echo "----"
ls
echo "----"

for i in $(seq 0 $MAX_I); do
	#--name = "$NAME""$i"
	#--rm = automatically remove container when exists
	# -i  = keep stdin open
	# -t  = allocate pseudo tty
	# -d  = detach
	# -p  = portmapping
	# dockertest:latest = name
	docker run --name "$NAME""$(printf %03d $i)" --rm -i -t -d -p $((2200+$i)):22 -p $((7000+$i)):5901/tcp dockertest:latest &
	sleep 0.1
done

for i in $(seq 0 $MAX_I); do
	docker exec "$NAME""$(printf %03d $i)" sh -c "echo $i > $FILE; echo $MAX_I >> $FILE;"
done