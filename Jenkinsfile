pipeline {
    agent any

    environment {
        IMAGE_NAME = "practice-app"
        DOCKER_REPO = "maizmazin"
        IMAGE_TAG = "${BUILD_ID}"  // Use Jenkins build ID as the version tag
    }

    stages {
        stage("code") {
            steps {
                git url: "https://github.com/Mazin2k2/django-notes-app.git", branch: "main"
                echo 'Code Cloned'
            }
        }
        stage("build and test") {
            steps {
                // Build Docker image with Jenkins build ID as the tag
                sh "docker build -t ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG} ."
                echo 'Code Built and Image Tagged'
            }
        }
        stage("push") {
            steps {
                withCredentials([usernamePassword(credentialsId: "dockerHub", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                    // Log in to Docker Hub
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    
                    // Tag the image with the Jenkins build ID and push it to Docker Hub
                    sh "docker tag ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG} ${env.dockerHubUser}/${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${env.dockerHubUser}/${IMAGE_NAME}:${IMAGE_TAG}"
                    echo 'Image Pushed to Docker Hub'
                }
            }
        }
        stage("deploy") {
            steps {
                echo "Deploying the container"
                // Deploy the container using docker-compose
                sh "docker-compose down && docker-compose up -d"
            }
        }
    }
}
