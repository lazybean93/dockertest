# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

#sleep 60
cd "$SCRIPTPATH";
docker run -d \
        -i \
        -t \
        --name "Kleinanzeigen" \
        --rm \
        -p 50222:22 \
        -p 56101:5901 \
        dockertest:latest &
while [ -z "$(docker ps | grep Kleinanzeigen)" ]; do
        sleep 1
done

sleep 2

FILE_Credentials="/home/automate/Kleinanzeigen/credentials.txt"
ECHO_Mail="echo oliver.tiebe@gmail.com >> ""$FILE_Credentials"
ECHO_Pass="echo '"';Ug$>bCfwM/\)"5b'"' >> ""$FILE_Credentials"
CMD="$ECHO_Mail""; ""$ECHO_Pass"
docker exec --user automate "Kleinanzeigen" sh -c "$(echo $CMD)"
