# Setup Base Image
FROM golang:1.9

#
# Setup
#
# Add Environment Variables
ENV APP_PATH /go/src/lesson-2

# Setup Working Directory
WORKDIR ${APP_PATH}

#
# Install Software Dependencies
#
# RUN apt-get

#
# Add Code and Golang Dependencies
#
# Add Code
COPY src ${APP_PATH}

# Get and Install Go Dependencies
RUN go get -d -v ./...
RUN go install -v ./...


#
# Network Dependencies
#
# EXPOSE instruction does not actually publish port, requires -p  in docker run
EXPOSE 8080

CMD ["lesson-2"]