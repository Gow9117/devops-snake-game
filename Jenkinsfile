pipeline {
    agent any

    tools {
        jdk 'java-21'
        maven 'maven'
    }

    environment {
        IMAGE_NAME = "gow9117/devops-pipeline:${GIT_COMMIT}"
    }
    stages {

        stage('Git Checkout') {
            steps {
                git url: 'https://github.com/Gow9117/devops-snake-game.git', branch: 'main'
            }
        }

        stage('Compile') {
            steps {
                sh '''
                    mvn compile
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    mvn clean package
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    printenv
                    echo "Building Docker Image..."
                    docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "Logging into Docker Hub..."
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }
        stage('Docker Push') {
            steps {
                sh '''
                    echo "Pushing Docker Image to Docker Hub..."
                    docker push ${IMAGE_NAME}
                '''
            }
        }

    }
}