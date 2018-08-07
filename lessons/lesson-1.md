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

###

1. Switch to git lesson-1 tag
```
	$ git checkout -b lesson-1
```

2. Examine the Dockerfile




3. Start Container
4. Execute shell inside container



*Reference*
[Dockerfile](https://docs.docker.com/engine/reference/builder/)
[What is a Docker Image](https://stackoverflow.com/a/26960888/1122077)
[What is a Docker Image](https://docs.docker.com/v17.09/engine/userguide/storagedriver/imagesandcontainers/)

