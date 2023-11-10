# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

sleep 60
cd "$SCRIPTPATH";
docker run -d \
        -i \
        -t \
        --name "Pancake" \
        --rm \
        -p 50022:22 \
        -p 55901:5901 \
        dockertest:latest &
while [ -z "$(docker ps | grep Pancake)" ]; do
        sleep 1
done
sleep 2
docker exec "Pancake" sh -c "sh /home/automate/pancake/pancake_cron.sh"