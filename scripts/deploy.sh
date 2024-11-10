#!/bin/bash

# Export environment variables for Docker Compose
export DOCKER_REPO="$1"
export IMAGE_NAME="$2"
export IMAGE_TAG="$3"
export GITHUB_OWNER="$4"
export GITHUB_REPOSITORY="$5"

# Set Git safe directory
git config --global --add safe.directory /home/ubuntu/django-notes-github-cicd

# Define project directory
PROJECT_DIR="/home/ubuntu/django-notes-github-cicd"

# Check if the directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Directory $PROJECT_DIR does not exist! Cloning the repository..."
  # Clone the repository if the directory does not exist
  git clone https://github.com/$GITHUB_OWNER/$GITHUB_REPOSITORY.git $PROJECT_DIR
else
  echo "Directory $PROJECT_DIR exists. Pulling latest changes..."
  # Navigate to the project directory and pull the latest changes
  cd $PROJECT_DIR
  sudo chown -R $USER:$USER $PROJECT_DIR  # Ensure ownership
  git pull origin main
fi

# Ensure docker-compose.yml is present
if [ ! -f "$PROJECT_DIR/docker-compose.yml" ]; then
  echo "docker-compose.yml not found in the project directory!"
  exit 1
fi

# Debugging: Print image details
echo "Using image: $DOCKER_REPO/$IMAGE_NAME:$IMAGE_TAG"

# Pull the latest image from Docker Hub using Docker Compose
docker-compose pull

# Restart the application using Docker Compose
docker-compose down
docker-compose up -d
