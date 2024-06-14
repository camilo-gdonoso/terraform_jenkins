pipeline {
    parameters {
        booleanParam(name: 'autoApprovePlan', 
                     defaultValue: false, 
                     description: 'Automatically run apply after generating plan?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TERRAFORM_PATH        = 'C:\\Program Files (x86)\\Terraform'
        PATH                  = "${env.PATH};${TERRAFORM_PATH}"
    }

    agent any

    stages {
        stage('Verify Terraform') {
            steps {
                bat 'terraform --version'
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/camilo-gdonoso/terraform_jenkins.git'
            }
        }

        stage('Plan') {
            steps {
                bat 'terraform init'
                bat 'terraform plan -out tfplan'
            }
        }

        stage('Approve') {
            when {
                not { expression { params.autoApprovePlan } }
            }

            steps {
                script {
                    def plan = readFile('tfplan')
                    input message: "Do you want to apply the plan?",
                           parameters: [text(name: 'Plan', 
                                             description: 'Please review the plan', 
                                             defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                bat 'terraform apply -input=false tfplan'
            }
        }

        stage('Show Output') {
            steps {
                script {
                    def logFile = sh(script: 'cat /tmp/install_nginx_log.txt', returnStdout: true).trim()
                    echo "NGINX Installation Log: ${logFile}"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

