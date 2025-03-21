# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

if [ $# -eq 0 ]; then
	sleep 60;
fi
cd "$SCRIPTPATH";
docker run -d \
        -i \
        -t \
        --name "Pancake" \
        --rm \
        -p 50122:22 \
        -p 56001:5901 \
        dockertest:latest &
while [ -z "$(docker ps | grep Pancake)" ]; do
        sleep 1
done
sleep 2
docker exec --user automate "Pancake" sh -c "sh /home/automate/pancake/pancake_cron.sh"
