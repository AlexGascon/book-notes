### Layers
On section 2.1.3 it mentions that layers are sets of diffs. 

I always saw it more as a small subset of the entire image, not as differences between images. Also from how the diagram explains it, it looks like it is kind of a diff between versions, so not sure if it's really like that or if I just understood it wrong

Actually, by looking at this output of creating a container from an image from section 1.2.3:

```
Sending build context to Docker daemon  2.048kB
 Step 1/7 : FROM node
  ---> 2ca756a6578b
 Step 2/7 : LABEL maintainer ian.miell@gmail.com
 ---> Running in bf73f87c88d6
 ---> 5383857304fc
Removing intermediate container bf73f87c88d6
 Step 3/7 : RUN git clone -q https://github.com/docker-in-practice/todo.git
 ---> Running in 761baf524cc1
 ---> 4350cb1c977c
Removing intermediate container 761baf524cc1
Step 4/7 : WORKDIR todo
 ---> a1b24710f458
Removing intermediate container 0f8cd22fbe83
Step 5/7 : RUN npm install > /dev/null
 ---> Running in 92a8f9ba530a
npm info it worked if it ends with ok
 [...]
npm info ok
 ---> 6ee4d7bba544
Removing intermediate container 92a8f9ba530a
Step 6/7 : EXPOSE 8000
 ---> Running in 8e33c1ded161
 ---> 3ea44544f13c
Removing intermediate container 8e33c1ded161
Step 7/7 : CMD npm start
 ---> Running in ccc076ee38fe
 ---> 66c76cea05bb
Removing intermediate container ccc076ee38fe
Successfully built 66c76cea05bb
```

It really looks like layers are diffs, because each command creates a container (it returns the ID), then the next command runs inside that container, and when it finishes and gets a new container as a result it deletes the previous one (the `intermediate container`)

### Images vs Containers
> In the same way a process can be seen as an “application being executed,” a Docker container can be viewed as a Docker image in execution.

> If you’re familiar with object-oriented principles, another way to look at images and containers is to view images as classes and containers as objects.

### Commands
* **WORKDIR**: Not only changes the directory, but also determines which directory you're in by default when you start up your container

**Tag an image**: `docker build -t <name:tag>`
You can specify just a name, without a tag.


**Command to start a container**:

```
$ docker run -i -t -p 8000:8000 --name example1 todoapp
```

`-p` maps the container port to the host machine port
`--name` gives the container a unique name so we can refer to it later


**Check differences since a container started**
`docker diff <container-id>`

Three possibilities:
- `A` means the file has been added
- `C` means the file has been changed
- `D` means the file has been deleted


### Layered system
Docker uses copy-on-write strategy (instead of the usual copy-on-startup). It means starting multiple instances of the same image is very fast because the image contains everything that is needed already, all the things that are new are stored separately.

![](https://dpzbhybb2pdcj.cloudfront.net/miell2/Figures/01fig09_alt.jpg)

![](https://dpzbhybb2pdcj.cloudfront.net/miell2/Figures/01fig10_alt.jpg)
