pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        PATH = "${env.PATH};C:\\Program Files (x86)\\Terraform"
    }
    // prueba de automatico
    agent any

    stages {
        stage('Verify Terraform') {
            steps {
                sh 'terraform --version'
            }
        }
        
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/camilo-gdonoso/terraform_jenkins.git'
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
                not {
                    expression { params.autoApprove }
                }
            }

            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Quieres aplicar el plan?",
                        parameters: [text(name: 'Plan', description: 'Porfa revisa el plan', defaultValue: plan)]
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
                sh '''
                    terraform output
                '''
            }
        }
    }
}

