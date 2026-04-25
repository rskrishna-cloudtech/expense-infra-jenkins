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
                cd 01-vpc
                terraform plan
                """
            }
        }
        stage('Deploy') {
            input {
                message "Should we proceed?"
                ok "Yes, proceed"
            }
            steps {

                sh """
                cd 01-vpc
                terraform apply -auto-approve
                """
            }
        }
    }
    post{
        always{
            deleteDir()
        }
    }
}