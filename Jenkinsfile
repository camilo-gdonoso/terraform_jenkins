pipeline {
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        PATH = "${env.PATH};C:\\Program Files (x86)\\Terraform"
        PATH = "${env.PATH};C:\\ProgramData\\chocolatey"
    }
    // prueba de automatico
    agent any

    stages {
        stage('Verify Terraform') {
            steps {
                bat 'terraform --version'
            }
        }
        stage('Verify Terraform') {
            steps {
                bat 'choco -v'
            }
        }
        
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/camilo-gdonoso/terraform_jenkins.git'
            }
        }

        stage('Run Batch Script') {
            steps {
                bat 'scripts/install_nginx.bat'
            }
        }

        stage('Plan') {
            steps {
                bat 'terraform init'
                bat 'terraform plan -out tfplan'
                bat 'terraform show -no-color tfplan > tfplan.txt'
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
                bat 'terraform apply -input=false tfplan'
            }
        }
        stage('Show Output') {
            steps {
                script {
                    def logFile = bat(script: 'type C:\\tmp\\install_nginx_log.txt', returnStdout: true).trim()
                    echo "Registro de la instalación de NGINX: ${logFile}"
                }
            }
        }

    }
}

