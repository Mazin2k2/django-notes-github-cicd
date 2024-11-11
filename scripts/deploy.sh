#!/bin/bash

git config --global --add safe.directory /home/ubuntu/django-notes-github-cicd

PROJECT_DIR="/home/ubuntu/django-notes-github-cicd"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "Directory $PROJECT_DIR does not exist! Cloning the repository..."
  git clone https://github.com/$GITHUB_OWNER/$GITHUB_REPOSITORY.git $PROJECT_DIR
else
  echo "Directory $PROJECT_DIR exists. Pulling latest changes..."
  cd $PROJECT_DIR
  sudo chown -R $USER:$USER $PROJECT_DIR
  git pull origin main
fi

if [ ! -f "$PROJECT_DIR/docker-compose.yml" ]; then
  echo "docker-compose.yml not found in the project directory!"
  exit 1
fi

echo "Using image: $DOCKER_REPO/$IMAGE_NAME:$IMAGE_TAG"

if [[ -z "$DOCKER_REPO" || -z "$IMAGE_NAME" || -z "$IMAGE_TAG" ]]; then
  echo "Error: One or more image parameters are empty."
  exit 1
fi

docker-compose pull

docker-compose down
docker-compose up -d
