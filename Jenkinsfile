pipeline {
    agent any

    stages {
        stage("code") {
            steps {
                git url: "https://github.com/Mazin2k2/django-notes-app.git", branch: "main"
                echo 'Code Cloned'
            }
        }
        stage("build and test") {
            steps {
                sh "docker build -t practice-app ."
                echo 'Code Built'
            }
        }
        stage("push") {
            steps {
                withCredentials([usernamePassword(credentialsId: "dockerHub", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker tag practice-app:latest ${env.dockerHubUser}/practice-app:latest"
                    sh "docker push ${env.dockerHubUser}/practice-app:latest"
                    echo 'Image Pushed'
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    // Check if the container is already running
                    def containerStatus = sh(script: "docker ps -q -f name=practice-app", returnStdout: true).trim()
                    if (containerStatus) {
                        // Stop and remove the existing container
                        sh "docker stop practice-app"
                        sh "docker rm practice-app"
                    }
                    // Run the new container
                    sh "docker run -d -p 8080:8080 --name practice-app maizmazin/practice-app:latest"
                }
            }
        }
    }
}
