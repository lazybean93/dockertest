# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

if [ "$#" -ne 0 ]; then
        sleep 60
fi

if [ "$(docker ps | grep Kleinanzeigen | wc -l)" -lt 1]; then
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

        PREFIX="export DISPLAY=:1 \
            ; xmodmap /home/automate/Xmodmap \
            ; mkdir /home/automate/credentials"
        FILE_Credentials="/home/automate/Kleinanzeigen/credentials.txt"
        FILE_Credentials="/home/automate/credentials/kleinanzeigen.txt"
        ECHO_Mail="echo oliver.tiebe@gmail.com >> ""$FILE_Credentials"
        ECHO_Pass="echo '"';Ug$>bCfwM/\)"5b'"' >> ""$FILE_Credentials"
        SUFFIX="sh /home/automate/Kleinanzeigen/insertLatest.sh"
        SUFFIX="echo bla"
        CMD="$PREFIX""; ""$ECHO_Mail""; ""$ECHO_Pass""; ""$SUFFIX"

        docker exec --user automate "Kleinanzeigen" sh -c "$(echo $CMD)"
fi