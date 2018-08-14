# Lesson 2 - Simple Workflow
The purpose of this is to build a small webserver in Go and allow you to learn a common workflow for a application with no dependencies.

### PID 1
The process you run when you exec docker run will be the process with PID 1 (inside the process namespace of the container). This process is special in UNIX / Linux systems and it's the process in charge of 'adopting' any 'orphaned' process. If this process ends, all the processes will end also.

When PID 1 stops all children processes stop and your docker container stops too.

### Exposing Ports
Exposing Ports allows you to connect your host machine to your container. For example, you may run your web server on port `8080` on your container. Going to [http://localhost:8080]() on your host machine will not connect to your container's web server until the port is exposed.

### Rebuilding Images
There is a common "gotcha" when first working with Docker, where "dangling" or "orphaned" Docker images are created, when rebuilding Docker images. If your workflow requires you to rebuild your Docker Image every time you want to update source code in your container you'll run into this problem.

One of the main purposes of this lesson is to understand why they're created and how to minimize these artifacts.

### Mounting Filesystems
Mounting folders from your host to the container is the common paradigm used for developer workflows. Once your source folder is mounted you can edit the files on your host machine, then easily rebuild the application from the development container. This way you don't need to do `docker build` which creates the previously mentioned artifcats.


## Lab
### Important Concepts 
 - Examine Dockerfile
 - Expose Port
 - Mount Folder for Improved Workflow

### Begin Lab

#### 1. Switch to git lesson-1 tag
```bash
$ git checkout lessons/lesson-2
```

#### 2. Examine the Dockerfile

	1. What is the base image?
	2. What is the application path or working directory?
	3. What are the software dependencies?
	4. What command will be run when the container comes up?

###### EXPOSE
This `EXPOSE` command 

#### 3. Examine the Source Code

*[main.go]()*
`main` function creates and runs a router

`NewRouter` function instantiates a PingController and sets the route `/ping`

*[ping.go]()*
`Index` function returns the value message "pong" in JSON format

#### 4. Build the Docker Image
One of the practices I've found helpful is wrapping my docker build and run commands into scripts. Look inside `scripts/build-container.sh` to see the build command we'll be running.


You're going to build the docker image using the `docker build` command. You'll pass the option `-f Dockerfile` to use the file named "Dockerfile" in the root directory. The option `-t docker-tutorial:lesson-2` will setup the name of the image as "docker-tutorial" with a version of "lesson-2". The Dockerfile copies files from the host, we set the path as `.` (period) to say, this directory is the path to those files.

*build-container.sh*
```bash
#!/bin/bash

# Enable kill on errors
set -e

echo 'Build API Application'

# Build API Application
docker build -f Dockerfile -t docker-tutorial:lesson-2 . 
```

Let's run the script

```bash
$ ./scripts/build-container.sh
```

#### 5. Start Container
You're going to start your container by running the docker image using the `docker run` command. The last parameter is the image name and tag that was created in the previous build command.

The option `-rm` will cleanup and remove the container when it's done running. It's not required and during some troubleshooting scenarios it may not be used, but generally this option is included when running a container. We won't pass the `-it` parameter, because we will not use the interactive shell that we used in Lesson 1.


```bash
# Start the Container
$ docker run --rm docker-tutorial:lesson-2 
```

What is the output of the shell?
Can you interact with the container or are you stuck looking at logs?

In Lesson 1, the command being run was `/bin/sh`, this container runs the Go Application. Containers only stays up while this application is running, so if we kill the web app we won't be able to access the server. The good thing is we're going to learn how to access the container while the web server is running.


#### 6. Access a Running Container's Shell
Open a new terminal window. Let's see what docker containers are running with the `docker ps` command. The response from `docker ps` won't look exactly like mine, but note the "name" of your container. You can provide a name, if not docker will auto-generate one for you if you don't.

```bash
# Show the running Docker containers
# Notice the name of my container is "hardcore_mayer"
$ docker ps 
CONTAINER ID        IMAGE                      COMMAND             CREATED             STATUS              PORTS               NAMES
cf48298b8948        docker-tutorial:lesson-2   "lesson-2"          24 minutes ago      Up 24 minutes       8080/tcp            hardcore_mayer

# Gain access to the container's command line 
# Replace <container name> with your container name
$ docker exec -it <container name> bash

# curl the ping endpoint and check the response
root@33adde3a571e:/go/src/lesson-2# curl http://127.0.0.1:8080/ping
{"message":"pong"}

```

On your host machine, go to the page [http://localhost:8080/ping](http://localhost:8080/ping)

What happened? You shouldn't be able to connect to a server.

If you remember in the Dockerfile port 8080 was exposed. Unfortunately, that really doesn't do anything. When we run the docker container, we need to expose the port.

Kill the docker container using `ctrl+c` or maybe `ctrl+shift+c`.

#### 7. Expose a Container's Port
Run the container again, but this time using the option `-p 8000:8080` this will expose port 8000 on the host and map it to port 8080 on the container. We'll also add `--name lesson-2` to name the container.

```bash
$ docker run -it -p 8000:8080 --name lesson-2 --rm docker-tutorial:lesson-2
```

In your second shell check that you can connect to the web server.

```bash
$ docker exec -it lesson-2 bash

# curl the ping endpoint and check the response
root@33adde3a571e:/go/src/lesson-2# curl http://127.0.0.1:8080/ping
{"message":"pong"}
```
Go to the URL [http://localhost:8000/ping]() on host. You should see the pong JSON message from both. 

Kill the docker container using `ctrl+c` or maybe `ctrl+shift+c`.

#### 8. Rebuild the Container
We're going to rebuild our container and point out the problem with rebuilding containers, then the improve our workflow.

Change "pong" response to "kong" in `src/controllers/ping.go`.

Rebuild and run the container to verify the change.

```bash
$ docker build -f Dockerfile -t docker-tutorial:lesson-2 .
$ docker run -it -p 8000:8080 --name lesson-2 docker-tutorial:lesson-2
```

Verify the change at [http://localhost:8000/ping](). 

Ok, that works... but let's look at an issue.

```bash
$ docker images
docker-tutorial     lesson-2            1e0daf868e63        8 seconds ago       791MB
<none>              <none>              27de414fa847        4 days ago          791MB
golang              1.9                 ef89ef5c42a9        4 weeks ago         750MB
```

You might see something that looks like above. What's the `<none> <none>` image? That's the image that was originally returning "pong". That's because docker doesn't get rid of the old image you built. It just builds a new image, then moves that tag you were using before to the new image. (Kinda silly, but that's how it works)

So now you have your the new image you built with the tag you want and the old image, but it doesn't have a tag anymore.

This workflow isn't ideal. What we want to do is be able to modify code on the host machine and the docker container without having to rebuild a docker image.

#### 9. Mounting Folders
When you run a Doker container you can also add a command line option to mount a directory from the host to the container. This is used for most development workflows because it allows you to use your IDE/Editor from your host machine while keeping your container running. Then you can easily rebuild your system. To mount a directory you will use the `mount` option with your `docker run` command.


```bash
# Run Container, override command with bash
$ docker run -it -p 8000:8080 \
 --name lesson-2 \
 --mount type=bind,source="$(pwd)/src",target=/go/src/lesson-2 \
 --rm \
 docker-tutorial:lesson-2 \
 /bin/bash

# Start application
root@a85b9d803f5a:/go/src/lesson-2# go run main.go

```

Go to the URL [http://localhost:8000/ping]() on host

Change "kong" response to "song" in `src/controllers/ping.go`.


```bash
# Kill your application with ctrl+c or ctrl+shift+c
ctrl+c or ctrl+shift+c

# Run it again
root@a85b9d803f5a:/go/src/lesson-2# go run main.go

```

### Scripting things
As you can see, that's a long command line to remember. For that reason, I usually wrap docker commands in scripts.

You can check out the scripts directory and files to see a typical script I build.


### Review
This completes the lesson 2 Docker tutorial. You should have a little better understanding of the `docker build` quirks and why mounting folders is used for typical workflows. As well as an idea for setting up a simple environment.

You can continue learning more about Docker with [Lesson 3 - Docker Compose - Real Workflows](https://github.com/dgallegos/docker-tutorial/blob/lessons/lesson-3/lessons/lesson-3.md)


## References
[PID 1](https://stackoverflow.com/questions/28382937/when-does-a-docker-container-stop)

[Gin Web Framework for Go](https://github.com/gin-gonic/gin)