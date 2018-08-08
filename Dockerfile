# FROM 
# FROM <image>[:<tag>]
# FROM sets a pre-made base image that subsequent instructions are built on
#
# Docker will check if you have this image locally, if not it will check
# the Docker Hub Repository. You can add Public and Private Docker Image Repositories
# 
# Docker Hub Link - https://hub.docker.com/_/alpine/
FROM alpine:3.7

# ENV 
# ENV <key> <value>
# ENV adds Environment Variables
# They can be used by Dockerfile and will be availing in the running container environment
ENV LESSON lesson-1
ENV APP_ROOT /opt/docker-tutorial

# WORKDIR
# WORKDIR <path>
# Set the working directory of the docker image. 
WORKDIR ${APP_ROOT}

# COPY
# COPY <SRC> <DEST>
# Copies files from the host machine to the Docker Image
COPY src ${APP_ROOT}

# RUN
# RUN ${APP_ROOT}/create-files.sh

# CMD
# Run bash command at startup
CMD ["/bin/sh"]
