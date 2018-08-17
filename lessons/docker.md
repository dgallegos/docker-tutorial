# Docker
> "Build, Ship, and Run Any App, Anywhere"

Docker is a software platform that performs "containerization". It is the de facto standard for container building and runtime.

In fact [Open Container Initiative (OCI)](https://en.wikipedia.org/wiki/Open_Container_Initiative) spec has largely been driven and lead by Docker.

Containers are an idea created by Linux, but setting up a container requires doing a lot of low level manual commmands. Docker is a pretty User Interface that made containerization easy to use.

## Docker Benefits
Docker didn't create containers, but they've done things right to bring it to the masses.

### Shared Images are a First Class Concept
Docker easily allows you to share images through Docker registries, then build off existing images with Dockerfiles.

 - They created a public repository where they've got premade software images available. They also allow people to upload their own images or use private repositories.
 - They allow users to easily build on top of existing images. So once you get a public image, you can add whatever you need to fit your needs.

### Works Well Out of the Box
Docker handles networks, file system momunts, composition, and orchestration.

What the above means is, not only does Docker handle simple use-cases during development, you can test networked containers and scaling containers.

### Dockerfiles
Dockeriles are easy to read, easy to write, with a lower barrier to entry adoption is wide.

## What makes up Docker
The core components that make up Docker are

 - Docker Daemon
 - Docker Client
 - Docker Registries

### Docker Daemon
The Docker daemon (`dockerd`) listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. A daemon can also communicate with other daemons to manage Docker services.

### Docker Client
The Docker client (`docker`) is the primary way that many Docker users interact with Docker. When you use commands such as `docker run`, the client sends these commands to `dockerd`, which carries them out. The `docker` command uses the Docker API. The Docker client can communicate with more than one daemon.


### Docker Registries
A Docker registry stores Docker images. Docker Hub and Docker Cloud are public registries that anyone can use, and Docker is configured to look for images on Docker Hub by default. You can even run your own private registry. If you use Docker Datacenter (DDC), it includes Docker Trusted Registry (DTR).

## Lab
Let's jump into a lab and try this docker thing out. [Lesson 1 - Dockerfiles and Containers](https://github.com/dgallegos/docker-tutorial/blob/lessons/lesson-1/lessons/lesson-1.md)


# References
[Docker Overview](https://docs.docker.com/engine/docker-overview/#docker-objects)

[Corwin on Containers](https://www.slideshare.net/CorwinBrown1/corwin-on-ccontainers)