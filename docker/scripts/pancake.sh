docker run -d \
        -i \
        -t \
        --name "Pancake" \
        --rm \
        -p 50022:22 \
        -p 55901:5901 \
        dockertest:latest &
while [ -z "$(docker ps | grep Pancake)" ]; do
        sleep 1
done
sleep 2
docker exec --user automate "Pancake" sh -c "sh /home/automate/pancake/pancake_cron.sh"