# Lesson 1 - Dockerfiles and Containers
The purpose of this lesson is to get familiar with Dockerfiles and running containers. There are a couple important terms to be familiar with before we start.

## Lifecycle Comparison
To begin, let's take a quick glance at the states of a Docker container in comparison to an application.

![alt text](https://github.com/dgallegos/docker-tutorial/blob/master/lessons/images/code-container-lifecycle.png "Code Container Lifecycle")

## What is a Dockerfile?
A `Dockerfile` is a text document that contains all the commands a user calls to assemble an image. 

This is the recipe to recreate an image. This set of instructions help you know what goes into your image. The command you'll use later in the lab to build you image from a dockerfile is `docker build`.

## What is a Docker Image?
A Docker image is the built-up filesystem created by a Dockerfile. Each command in the Dockerfile is like a git commit that adds a layer to the image. 

If you run the `docker history <image-id>` command you can see all the layers that build up your Docker image. Each layer is only a set of differences from the layer before it. Commands can copy files, set ENV variables, execute commands, and do many other actions.

## What is a Container?
A container is the running instantiation of a image. Without going into the details, a container is similar to a lighter weight Virtual Machine.

### Container Caveats

#### Conatiners are Stateless
Changes made to a container are lost once your container ceases to exist or you restart it. Data does not live on a container. When you close and restart the container, you container goes back to the state of the Docker Image.

In a later lab you will learn how to connect a container to a database and mount a folder from your host filesystem to help your container keep state.


## Lab

### Important Concepts 
 - Examine Dockerfile
 - Build an Image
 - Run the Container
 - Verify Images are Immutable
 - Modify a Dockerfile and Rebuild the Image

### Software Prerequisites (Must Install)
 - [Docker](https://docs.docker.com/install/)

### Begin Lab

#### 1. Switch to git lesson-1 branch
```bash
$ git checkout lessons/lesson-1
```

#### 2. Examine the Dockerfile
Open the [Dockerfile](https://github.com/dgallegos/docker-tutorial/blob/lessons/lesson-1/Dockerfile) and begin examining it. Below are some keywords used in the Dockerfile.

 - FROM
 - ENV
 - WORKDIR
 - COPY
 - CMD

###### FROM
The `FROM` command sets the base image. One of the features that helped Docker become the de facto container leader, is the ease of sharing and reusing images. 

The FROM command checks if the image exists locally, if not, it attempts to pull the image from the [Docker Hub repository](https://docs.docker.com/docker-hub/). 

###### ENV
This `ENV` command sets the environment variable. The environment variable can be used during the building of the Docker image in the Dockerfile as well as once the Docker container is running.

###### WORKDIR
The `WORKDIR` instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.

###### COPY
The COPY instruction copies new files or directories from <src> and adds them to the filesystem of the container at the path <dest>

|	The Copy Feature supports a --chown parameter for Linux containers


###### CMD
The main purpose of a `CMD` is to provide defaults for an executing container.


#### 3. Build the docker image
You're going to build the docker image using the `docker build` command. You'll pass the option `-f Dockerfile` to use the file named "Dockerfile" in the root directory. The option `-t docker-tutorial:lesson-1` will setup the name of the image as "docker-tutorial" with a version of "lesson-1". The Dockerfile copies files from the host, we set the path as `.` (period) to say, this directory is the path to those files.


```bash
# Build the Docker Image
$ docker build -f Dockerfile -t docker-tutorial:lesson-1 .

# View the history of how the image was created
$ docker history docker-tutorial:lesson-1
```


#### 4. Start Container
You're going to start your container by running the docker image using the `docker run` command. You'll pass the `-it` options to make it an interactive terminal. The last parameter is the image name and tag that was created in the previous build command.


```bash
# Run the Docker Image 
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


#### 5. Verify Images are Immutable
Next we're going to test what it means for the Docker image/container to be immutable.

```bash
# Delete lesson-1.sh file
/opt/docker-tutorial # rm lesson-1.sh

# Verify the file is removed
/opt/docker-tutorial # ls -al

# Exit Docker
/opt/docker-tutorial # exit
```

We've exited Docker. Now, we're going to run the Docker Image and check if the file stays removed.

```bash
# Run docker again
$ docker run -it docker-tutorial:lesson-1 

# List the working directory contents
/opt/docker-tutorial # ls -al
```

After restarting the container, does the file exist?


#### 6. Modify Dockerfile and Rebuild Container
Uncomment the `RUN` command line in the [Dockerfile](https://github.com/dgallegos/docker-tutorial/blob/lessons/lesson-1/Dockerfile).


```Dockerfile
	# Run Command
	RUN ${APP_ROOT}/create-files.sh

```

###### RUN
The `RUN` instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the 

Rebuild the application, start the container and view the new files.


```bash
# Build the Image using the same tag as before
$ docker build -f Dockerfile -t docker-tutorial:lesson-1 .

# List working directory files
/opt/docker-tutorial # ls -al
```

Now you can see how the `RUN` command in a Dockerfile runs processes inside the container to build the image.

### Review
This completes the lesson 1 Docker tutorial. You should have the basic understanding to read a Dockerfile and get it running.

You can continue learning more about Docker with [Lesson 2 - Simple Workflow: Mounting Folders and Exposing Ports](https://github.com/dgallegos/docker-tutorial/blob/lessons/lesson-2/lessons/lesson-2.md)


## Reference
[Dockerfile](https://docs.docker.com/engine/reference/builder/)

[What is a Docker Image](https://stackoverflow.com/a/26960888/1122077)

[What is a Docker Image](https://docs.docker.com/v17.09/engine/userguide/storagedriver/imagesandcontainers/)

