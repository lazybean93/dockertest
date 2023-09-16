ssh-keygen -f "/home/oliver/.ssh/known_hosts" -R "[localhost]:""$1" > /dev/zero 2>&1
expect expect.sh "$1"