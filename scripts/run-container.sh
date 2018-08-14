#!/bin/bash

# Enable kill on errors
set -e

echo 'Run API Application'

# Long run command
docker run -it -p 8000:8080 \
 --name lesson-2 \
 --mount type=bind,source="$(pwd)/src",target=/go/src/lesson-2 \
 --rm \
 docker-tutorial:lesson-2 \
 /bin/bash