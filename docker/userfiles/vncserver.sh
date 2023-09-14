CMD="ps aux | grep -v grep | grep Xtightvnc"
sh -c "$CMD"
if [ -z "$(sh -c "$CMD")" ]; then
	export USER=automate
	tightvncserver
fi
sh -c "$CMD"
