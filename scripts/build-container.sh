#!/bin/bash

# Enable kill on errors
set -e

echo 'Build API Application'

# Build API Application
docker build -f Dockerfile -t docker-tutorial:lesson-2 . 