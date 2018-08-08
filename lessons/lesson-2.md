# Lesson 2 - Building a Web Server in Go
The purpose of this is to build a small webserver in Go and allow you to learn a common workflow for a simple application.


## Lab
### Important Concepts 
 - Examine Dockerfile


### Begin Lab

1. Switch to git lesson-1 tag
```
	$ git checkout lessons/lesson-2
```

2. Examine the Dockerfile

	1. What is the base image?
	2. What is the application path or working directory?
	3. What are the software dependencies?



3. Build the docker image
You're going to build the docker image using the `docker build` command. You'll pass the option `-f Dockerfile` to use the file named "Dockerfile" in the root directory. The option `-t docker-tutorial:lesson-1` will setup the name of the image as "docker-tutorial" with a version of "lesson-1". The Dockerfile copies files from the host, we set the path as `.` (period) to say, this directory is the path to those files.


```
	$ docker build -f Dockerfile -t docker-tutorial:lesson-2 .
```

3. Start Container
You're going to start your container by running the docker image using the `docker run` command. You'll pass the `-it` options to make it an interactive terminal. The last parameter is the image name and tag that was created in the previous build command.



```
	$ docker run -it docker-tutorial:lesson-2
```

Try to go to page it fails. Exec into container and view that it works.

```
```

Explain how the dockerfile expose, doesn't actually do antyhing. It's merely for documentation. Stop docker container.

Run docker container with -p option

```
	$ docker run -it -p 8000:8080 docker-tutorial:lesson-2
```

Go to localhost:8080/ping on host
Go to localhost:8000/ping on host



5. Change code

Change "pong" response to "kong" in controllers/ping.

Rebuild app. Run app and verify it works

```
	$ docker build -f Dockerfile -t docker-tutorial:lesson-2 .
	$ docker run -it docker-tutorial:lesson-2
```
Verify it works by going to the site. 

Ok, that works... but that's not a very good workflow. Having to rebuild all the time is slow.