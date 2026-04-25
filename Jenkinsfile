pipeline {
    agent {
        label 'AGENT-1'
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }

    stages {
        stage('Init') {
            steps {
                sh """
                cd 01-vpc
                terraform init -reconfigure

                """
            }
        }

        stage('Plan') {
            steps {
                sh """
                
                """
            }
        }
        stage('Deploy') {
            steps {
                sh """

                """
            }
        }
    }
}