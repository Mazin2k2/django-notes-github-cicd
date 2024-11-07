pipeline {
    agent any

    environment {
        IMAGE_NAME = "practice-app"
        DOCKER_REPO = "maizmazin"
        IMAGE_TAG = "${BUILD_ID}"  
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
                sh "docker build -t ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG} ."
                echo 'Code Built and Image Tagged'
            }
        }
        stage("push") {
            steps {
                withCredentials([usernamePassword(credentialsId: "dockerHub", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker tag ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG} ${env.dockerHubUser}/${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${env.dockerHubUser}/${IMAGE_NAME}:${IMAGE_TAG}"
                    echo 'Image Pushed to Docker Hub'
                }
            }
        }
        stage("deploy") {
            steps {
                echo "Deploying the container"
                withEnv(["DOCKER_REPO=${DOCKER_REPO}", "IMAGE_NAME=${IMAGE_NAME}", "IMAGE_TAG=${IMAGE_TAG}"]) {
                sh "docker-compose down && docker-compose up -d"
                }
            }
        }
    }
}
