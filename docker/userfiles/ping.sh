for i in $(seq 0 127); do
	ping -c 1 172.17.0.$i;
done > ping.txt
#cat ping.txt | grep -v '100% packet loss' | grep -C1 '% packet loss' | grep ping | sed 's/ /\n/g' | grep [0-9] > ip.txt
#rm ping.txt
#mv ip.txt ping.txt