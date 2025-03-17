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
        --name "Pankeep" \
        --rm \
        -p 50322:22 \
        -p 56201:5901 \
        dockertest:latest &
while [ -z "$(docker ps | grep Pankeep)" ]; do
        sleep 1
done
sleep 2
docker exec --user automate "Pankeep" sh -c "sh /home/automate/pankeep/pankeep_cron.sh"
