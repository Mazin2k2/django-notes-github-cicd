pipeline {
    agent any
    
    stages {
        
        stage("code") {
            steps {
                git url: "https://github.com/Mazin2k2/node-todo-app-pipelined", branch: "master"
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
                    def image = "${env.dockerHubUser}/practice-app:latest"
                    sh "docker stop \$(docker ps -q --filter ancestor=${image}) || true"
                    sh "docker rm \$(docker ps -aq --filter ancestor=${image}) || true"
                    sh "docker rmi \$(docker images -q ${image}) || true"
                    sh "docker run -d -p 8080:8080 --name practice-app ${image}"
                    echo 'Deployment Done'
                }
            }
        }
    }
}
