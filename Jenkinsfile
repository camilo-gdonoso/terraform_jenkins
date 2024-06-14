pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
    }

    stages {
        stage('Verify Terraform') {
            steps {
                sh 'terraform --version'
                sh 'choco -v'
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/camilo-gdonoso/terraform_jenkins.git'
            }
        }

        stage('Run Batch Script') {
            steps {
                sh 'scripts/install_nginx.bat'
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform init'
                sh 'terraform plan -out tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Approve') {
            when {
                expression { !params.autoApprove }
            }

            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Apply plan?",
                        parameters: [text(name: 'Plan', description: 'Review plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                sh 'terraform apply -input=false tfplan'
            }
        }

        stage('Show Output') {
            steps {
                script {
                    def logFile = sh(script: 'type C:\\tmp\\install_nginx_log.txt', returnStdout: true).trim()
                    echo "NGINX Installation Log: ${logFile}"
                }
            }
        }
    }
}

