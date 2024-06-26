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
        stage('Planificando Terraform y confirmando'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage('Creating/Destroying an EKS Cluster'){
            steps{
                script{
                    dir('EKS') {
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        stage('Deploying Nginx Application') {
            steps {
                dir('EKS/ConfigurationFiles') {
                    sh 'aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster'
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}