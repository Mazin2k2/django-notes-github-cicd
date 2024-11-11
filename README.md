****CI/CD Dockerized Web App****
This GitHub repository contains files that demonstrate how to build, push, and deploy a simple Python web app using Docker, GitHub Actions, and AWS EC2.

****Key Features****
1. Python Web App.
2. Docker.
3. CI/CD Pipeline using GitHub ACtions.

****Files in the Repo****
1. app.py: A simple Python web app using the web.py framework that responds with a greeting.
2. Dockerfile: Defines how to build the Docker image for the app.
3. docker-compose.yml: Configures Docker Compose to run the app container.
4. deploy.sh: Shell script that deploys the app on an EC2 instance by pulling the latest changes and restarting the container.
5. .github/workflows/ci-cd.yml: GitHub Actions workflow that: Builds and pushes the Docker image to Docker Hub, then deploys it to EC2 using the deploy.sh script.
   
