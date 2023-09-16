set PORT [lindex $argv 0]
spawn ssh automate@localhost -p $PORT
expect "?"
send "yes\r"
expect "word:"
send "automate\r"
interact
