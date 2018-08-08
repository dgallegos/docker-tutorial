# The FROM command sets the base image for subsequent instructions.
FROM alpine:3.7

# Add Environment Variables
# They can be used by Dockerfile and will be in the container environment
ENV LESSON lesson-1
ENV APP_ROOT /opt/docker-tutorial

WORKDIR ${APP_ROOT}

# COPY Command
COPY src ${APP_ROOT}

# Run Command
RUN ${APP_ROOT}/create-files.sh

# Run bash command at startup
CMD ["/bin/sh"]
#CMD ["/bin/sh", "-c","tail -f /dev/null"]