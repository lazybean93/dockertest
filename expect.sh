spawn ssh automate@localhost -p 2121
expect "?"
send "yes\r"
expect "word:"
send "automate\r"
interact
