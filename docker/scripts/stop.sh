docker stop $(docker ps | grep dockertest | sed 's/ /\n/g' | grep -C3 dockertest | grep -v '^$\|latest\|--' | sed 's/$/ /g' | tr -d '\n') & git pull
