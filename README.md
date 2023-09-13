# dockertest
Just a test.

In folder docker there is a Dockerfile. You can build it with ```python
docker build --pull --rm -f "Dockerfile" -t test:latest "."
```. Run happens with ```python
docker run --rm -it -p 2121:22 -p 6001:5901/tcp test:latest"
```. Keep attention to the port forwarding.

It starts an ssh and an vnc server.

# Helpers
sshConnect.sh connects to the ssh server and calls expect.sh. 
