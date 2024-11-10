#!/bin/bash

# Set Git safe directory
git config --global --add safe.directory /home/ubuntu/django-notes-github-cicd

# Define project directory
PROJECT_DIR="/home/ubuntu/django-notes-github-cicd"

# Check if the directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Directory $PROJECT_DIR does not exist! Cloning the repository..."
  git clone https://github.com/$GITHUB_OWNER/$GITHUB_REPOSITORY.git $PROJECT_DIR
else
  echo "Directory $PROJECT_DIR exists. Pulling latest changes..."
  cd $PROJECT_DIR
  sudo chown -R $USER:$USER $PROJECT_DIR
  git pull origin main
fi

# Ensure docker-compose.yml is present
if [ ! -f "$PROJECT_DIR/docker-compose.yml" ]; then
  echo "docker-compose.yml not found in the project directory!"
  exit 1
fi

# Debugging: Print image details
echo "Using image: $DOCKER_REPO/$IMAGE_NAME:$IMAGE_TAG"

# Check if the image details are valid
if [[ -z "$DOCKER_REPO" || -z "$IMAGE_NAME" || -z "$IMAGE_TAG" ]]; then
  echo "Error: One or more image parameters are empty."
  exit 1
fi

# Pull the latest image from Docker Hub using Docker Compose
docker-compose pull

# Restart the application using Docker Compose
docker-compose down
docker-compose up -d
