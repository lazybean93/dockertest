if [ "$#" -eq "0" ]; then
        echo "Syntax sshConnect.sh *PORT*"
        exit
fi

if [ "$#" -gt "1" ]; then
        echo "Syntax sshConnect.sh *PORT*"
        exit
fi

# Absolute path to this script. /home/user/bin/foo.sh
SCRIPT=$(readlink -f $0)
# Absolute path this script is in. /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

ssh-keygen -f "/home/oliver/.ssh/known_hosts" -R "[localhost]:""$1" > /dev/zero 2>&1
expect "$SCRIPTPATH""/expect.sh" "$1"