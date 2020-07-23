# Chapter 3 - Using Docker as a lightweight virtual machine

The initial sections of the chapter (**Technique 10, 11 and 12**) contain some useful tips to migrate a VM to use Docker, starting with migrating the entire host and going to steps like breaking it up into smaller containers

### Command chaining
Chaining commands is useful to make sure that a combination of commands are always run together. This is useful for example if you install a dependency: if you have `RUN apt-get update && apt-get install postgresql` you will always get the last version of postgres, but if you run separate commands `RUN apt-get update` and `RUN apt-get install postgresql` the first one might use a cached version and therefore not update the repository.

### docker commit
When you are making live changes to a docker container from its inside, you can use `docker commit` to save the state. This can be very useful for example if you are working on a project and reached a specific checkpoint that is working, and want to be sure you'll be able to go back to it before continue making changes.

However, this won't capture running processes, only standard files, so don't consider this a silver bullet. Also, this is like an easy-to-use approach while you are still trying different things; a more sustainable way of doing this on the long term is keep a .txt file (or similar) next to you with and register all the changes you do or all the commands you run, so later it will be easier to migrate them into a real Dockerfile
