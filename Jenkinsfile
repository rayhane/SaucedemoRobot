pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rayhane/SaucedemoRobot.git'
            }
        }

        stage('Install dependencies') {
            steps {
                bat 'python -m pip install --upgrade pip'
                bat 'python -m pip install robotframework'
                bat 'python -m pip install robotframework-seleniumlibrary'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'python -m robot --outputdir results tests/'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
        }
    }
}