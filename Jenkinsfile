pipeline{
    agent any

    tools {
        jdk 'java-21'
        maven 'maven'
    }
    stages{
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
                    mvn package
                '''
            }
        }
        stage('Docker Build') {
            steps {
                printenv
                echo "Building Docker Image..."
                sh '''
                    docker build -t devops:latest .
                '''
            }
        }
    }
}