export USER=automate
export FOLDER="/home/""$USER""/"
export FOLDER_BOOT="$FOLDER"".boot/"
mkdir "$FOLDER_BOOT"
tightvncserver > "$FOLDER_BOOT""tightvncserver.txt" 2>&1
git pull > "$FOLDER_BOOT""git_pull.txt" 2>&1
#sh "$FOLDER""getID.sh"
#while [ $(bc <<< "$(sh "$FOLDER""load.sh" 1) < 0.1") -eq 0 ]; do
#    sleep $(echo $(sh "$FOLDER""random.sh")*30 | bc);
#nmap -p 22 172.17.0.1/24 | grep -C5 open | grep -v '^$' | grep for | sed "s/$(hostname)//g" | sed 's/(//g;s/)//g;s/ /\n/g' | grep '\.' > "$FOLDER_BOOT""hosts.txt"
#done