printf "%d\n" 0x$(head --bytes 4 /dev/random | hexdump | head -n1 | sed 's/ //g')
