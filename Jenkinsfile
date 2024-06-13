pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        PATH = "${env.PATH};C:\\Program Files (x86)\\Terraform"
    }

    agent any

    stages {
        stage('Verify Terraform') {
            steps {
                script {
                    // Ejecuta el comando para verificar la versión de Terraform
                    bat 'terraform --version'
                }
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
                bat 'terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Approval') {
            when {
                not {
                    expression { params.autoApprove }
                }
            }

            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                           parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                bat 'terraform apply -input=false tfplan'
            }
        }
    }
}

