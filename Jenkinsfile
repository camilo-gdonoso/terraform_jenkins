pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout SCM'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/camilo-gdonoso/terraform_jenkins.git']])
                }
            }
        }
        stage('Iniciando Terraform'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Formateando Codigo Terraform'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validando Terraform'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the Infrastructure') {
            steps {
                dir('EKS') {
                    try {
                        sh 'terraform plan -out=tfplan'
                    } catch (Exception e) {
                        throw error "Error during terraform plan: ${e.message}"
                        }
                }
            }
        }
        stage('Applying the Infrastructure') {
            steps {
                dir('EKS') {
                    script {
                    try {
                        sh 'terraform apply -auto-approve "tfplan"'
                    } catch (Exception e) {
                            error "Error during terraform apply: ${e.message}"
                    } finally {
                            sh 'rm -f tfplan'
                    }
                    }
                }
            }
        }
        stage('Deploying Nginx Application') {
            steps {
                dir('EKS/ConfigurationFiles') {
                    sh 'aws eks update-kubeconfig --name my-eks-cluster'
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}