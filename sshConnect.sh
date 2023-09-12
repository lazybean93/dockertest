ssh-keygen -f "/home/oliver/.ssh/known_hosts" -R "[localhost]:2121" > /dev/zero
expect expect.sh
