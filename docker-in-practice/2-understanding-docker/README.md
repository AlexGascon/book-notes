# Chapter 2 - Understanding Docker

## Docker's architecture
![](https://dpzbhybb2pdcj.cloudfront.net/miell2/Figures/02fig01_alt.jpg)

There are two parts: Docker daemon and Docker client
- The Docker daemon is the part that is continuously running . 
- The Docker client is what you invoke to execute operations. It communicates with the Docker daemon (via HTTP) to do things

#### Aclaration: daemons
A daemon is a background process, like a server

Usually an app has a client and a daemon that communicate. To differentiate them, the daemon ends with the letter 'd' (e.g. dockerd, etcd...)

## Docker Daemon
Some things that the daemon does:
- Controls access to Docker
- Manages state of the containers and images
- Handles interactions with the internet (e.g. to access an image registry)

## Port mapping

```
docker run -d -p 10001:80 --name blog1 tutum/wordpress
```

The `-p` command specifies the mapping of the port from the host machine to the container. `10001:80` means that the port 10001 on your laptop/server/whatever will point to the port 80 in whatever the container is running. So, if your container is running a webservice, you can access it via http://localhost:10001

**REMEMBERING THE ORDER**: It can be easy to forget which port is the container and which is the host. A way to remember it is like reading the connection flow and knowing it happens from left to right (like reading a sentence)

`The user connects to the port 10001 in its host, and that port connects to the port 80 in the container`

i.e. you first connect to the host, and then to the container

## Port linking
**NOTE: The --link flag is legacy and will eventually be removed. See [Legacy container links](https://docs.docker.com/network/links/)**

Port linking allows your containers to talk between themselves without you having to directly expose its ports. It is useful because you can have containers connected without exposing them to the network (or the outside world).

Example:

```
$ docker run --name wp-mysql -e MYSQL_ROOT_PASSWORD=yourpwd -d mysql

(Wait for a minute or two)

$ docker run --name wordpress --link wp-mysql:mysql -p 10003:80 -d wordpress
```

What these commands are doing is:

**First command**
- Create a container running a MySQL DB (`mysql` image) and give it the `wp-mysql` name
- Set the environment variable `MYSQL_ROOT_PASSWORD`. It's required so the container can initialize the DB

**Second command**
- Create a container running a wordpress blog (`wordpress` image) and give it the `wordpress` name
- Expose the port 80 and map it to the port 10003 in the local machine
- Send the references to a mysql server to the `wp-mysql` container

In order to do this, the ports need to be exposed in the image when building it. This can be achieved using `EXPOSE` in the Dockerfile

An important benefit of this is that, as you are linking the wordpress image to a container named `wp-mysql`, you can change that container whenever you want as long as it keeps its name. You could even switch to a different version or replace it with an entirely different one.

## Docker Registry
The book contains a technique about setting up a local Docker registry. While this is something very niche, it can also be veri useful, may be worth taking a look to the tip if I ever need one

It seems that while the registry is the current standard of an image hub, it will evolve to something called Distribution. See more on [GitHub](https://github.com/docker/distribution)

## Docker Hub
**Searching in Docker Hub**: There's a command, `docker search`, that allows you to search for images in Docker Hub directly from your command-line. It also provides useful information like the description or the number of stars


## Exercises
### Accessing your docker daemon from outside of your localhost
If you want to access it from external machines (e.g. to have Jenkins workflows triggering runs, or to allow your teammates to access your machine docker daemon) you can bind it to a TCP address

Instead of running on `/var/run/docker.sock`, it will be running on e.g. `tcp://0.0.0.0:2375`

1. Stop the current docker daemon
    1.1. Run either `sudo service docker stop` or `systemctl stop docker`
    1.2. Verify with `ps -ef | grep -E 'docker(d| -d| daemon)\b' | grep -v grep`. There shouldn't be any output (info: -e shows all, -f formats as full list, -E uses extended Regexp, -v inverts the match [this last part seems to work only to unselect, anything that doesn't match works])
2. Start a new daemon in the desired address:
    2.1.1 Run `sudo docker daemon -H tcp://0.0.0.0:2375` (info: -H defines host server, 0.0.0.0 specifies to use all addresses, 2375 is the standard Docker server port)
    2.1.2 Alternative: `export DOCKER_HOST=tcp://<ip>:2375 && docker <subcommand>`

