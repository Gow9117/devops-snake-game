pipeline{
    agent any

    tools {
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
    }
}