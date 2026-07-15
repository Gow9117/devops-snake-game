pipeline {
    agent any

    tools {
        jdk 'java-21'
        maven 'maven'
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
                    docker build -t devops:latest .
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

    }
}