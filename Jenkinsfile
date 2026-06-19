pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/rayhane/SaucedemoRobot.git'
            }
        }

        stage('Install dependencies') {
            steps {
                bat '''
                python -m pip install --upgrade pip
                pip install robotframework
                pip install robotframework-seleniumlibrary
                '''
            }
        }

        stage('Run Tests') {
            steps {
                bat '''
                robot --outputdir results .
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**/*'
        }
    }
}