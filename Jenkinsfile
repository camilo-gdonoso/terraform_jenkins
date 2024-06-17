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
                    sh 'terraform plan -out=tfplan'
                }
                input message: "Are you sure to proceed?", ok: "Yes"
            }
        }
        stage('Applying the Infrastructure') {
            steps {
                sh 'terraform apply tfplan'
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