# Lesson 1 - Dockerfiles and Containers
The purpose of this lesson is to get familiar with Dockerfiles and running containers. There are a couple important terms to be familiar with before we start.

## What is a Dockerfile?
A `Dockerfile` is a text document that contains all the commands a user could call on the command line to assemble an image. 

This is similar to source code. This is a set of instructions Docker uses to build an image. The command you'll use later in the lab to build you image is `docker build`.

## What is a Docker Image?
A Docker image is an inert, immutable file that's essentially a snapshot of a container. Just how a process is an instance of a program, a container is an instance of a image.

The Docker image is built up from a  series of layers. Each layer represents an instruction in the image's Dockerfile. If you run the `docker history <image-id>` command you can see all the layers that build up your Docker image. Each layer is only a set of differences from the layer before it.


## What is a Container?
A container is the running instantiation of a image. Without going into the details, a container is typically a lighter weight Virtual Machine. 

There caveats about a container you must know.

### Conatiners are Stateless
Changes made to a container are lost once your container ceases to exist or you restart it. Data does not live on a container. When you close and restart a program, you get the same set of executable code. When you close and restart a image, you get the container for that image.

In a later lab you will learn how to connect a container to a database and mount a folder from your host filesystem to help your container keep state.


## Lab
### Important Concepts 
 - Examine Dockerfile
 - Build an Image
 - Run the Container
 - Verify Stateless
 - Modify Dockerfile

### Begin Lab

1. Switch to git lesson-1 tag
```
	$ git checkout -b lessons/lesson-1
```

2. Examine the Dockerfile

 - FROM
 - ENV
 - WORKDIR
 - COPY
 - CMD

*FROM*
The `FROM` command sets the base image. One of the features that helped Docker become the de facto container leader, is the ease of sharing and reusing images. 

The FROM command checks if the image exists locally, if not, it attempts to pull the image from the [Docker Hub repository](https://docs.docker.com/docker-hub/). 

*ENV*
This `ENV` command sets the environment variable. The environment variable can be used during the building of the Docker image in the Dockerfile as well as once the Docker container is running.

*WORKDIR*
The `WORKDIR` instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.

*COPY*
The COPY instruction copies new files or directories from <src> and adds them to the filesystem of the container at the path <dest>

|	The Copy Feature supports a --chown parameter for Linux containers


*CMD*
The main purpose of a `CMD` is to provide defaults for an executing container.


3. Build the docker image
You're going to build the docker image using the `docker build` command. You'll pass the option `-f Dockerfile` to use the file named "Dockerfile" in the root directory. The option `-t docker-tutorial:lesson-1` will setup the name of the image as "docker-tutorial" with a version of "lesson-1". The Dockerfile copies files from the host, we set the path as `.` (period) to say, this directory is the path to those files.


```
	$ docker build -f Dockerfile -t docker-tutorial:lesson-1 .

```



3. Start Container
You're going to start your container by running the docker image using the `docker run` command. You'll pass the `-it` options to make it an interactive terminal. The last parameter is the image name and tag that was created in the previous build command.



```
	$ docker run -it docker-tutorial:lesson-1 


	# Run the lesson-1.sh script
	/opt/docker-tutorial # ./lesson-1.sh 
Hello Docker World!

	# Run ps aux to see running commands
	/opt/docker-tutorial # ps aux

	# Navigate/List the directories to see that it's, it's own file system
	/opt/docker-tutorial # ls -al /bin
	/opt/docker-tutorial # ls -al /
```

Next we're going to test what it means for the docker container to be immutable.

```
	# Delete lesson-1.sh file
	/opt/docker-tutorial # rm lesson-1.sh

	# Exit Docker
	/opt/docker-tutorial # exit

	# Run docker again
	$ docker run -it docker-tutorial:lesson-1 

	# List the working directory contents
	/opt/docker-tutorial # ls -al
```

When you removed the file, left the container and restarted the container. Was the file back?



4. Modify Dockerfile and Rebuild Container
Uncomment the `RUN` command line in the Dockerfile.


```
	# Run Command
	RUN ${APP_ROOT}/create-files.sh

```

*RUN*
The `RUN` instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the 

Rebuild the application, start the container and view the new files.


```
	$ docker build -f Dockerfile -t docker-tutorial:lesson-1 .

	# List working directory files
	/opt/docker-tutorial # ls -al
```

Now you can see how the `RUN` command in a Dockerfile runs processes inside the container to build the image.

*Reference*
[Dockerfile](https://docs.docker.com/engine/reference/builder/)
[What is a Docker Image](https://stackoverflow.com/a/26960888/1122077)
[What is a Docker Image](https://docs.docker.com/v17.09/engine/userguide/storagedriver/imagesandcontainers/)
