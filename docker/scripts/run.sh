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
pwd
echo "----"

#for i in $(seq 0 $MAX_I); do
        # -d  = detach
        # -i  = keep stdin open
        # -t  = allocate pseudo tty
        #--name = "$NAME""$i"
        #--rm = automatically remove container when exists
        # -p  = portmapping
        # dockertest:latest = name
#       docker run -d \
#               -i \
#               -t \
#               --name "$NAME""$(printf %03d $i)" \
#               --mount type=bind,source="$(pwd)"/Downloads,target=/home/automate/Downloads \
#               --rm \
#               -d \
#               -p $((2200+$i)):22 \
#               -p $((15900+$i)):5901 \
#               dockertest:latest &
#       sleep 0.1
#done

#for i in $(seq 0 $MAX_I); do
#       docker exec "$NAME""$(printf %03d $i)" sh -c "echo $i > $FILE; echo $MAX_I >> $FILE;"
#done

docker run -d \
	-i \
	-t \
	--name "Pancake" \
	--rm \
	-p 50022:22 \
	-p 55901:5901 \
	dockertest:latest &