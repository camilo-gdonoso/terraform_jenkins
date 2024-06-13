pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

agent  any
    stages {
        stage('checkout') {
            steps {
                script{
                        dir("terraform")
                        {
                            git "https://github.com/camilo-gdonoso/terraform_jenkins.git"
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                script {
                    dir("terraform") {
                        sh 'terraform init'
                        sh 'terraform plan -out tfplan || true'
                        sh 'terraform show -no-color tfplan > tfplan.txt || true'
                    }
                }
            }
                    }
        stage('Approval') {
        when {
            not {
                equals expected: true, actual: params.autoApprove
            }
        }

        steps {
            script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
            }
            }
        }

        stage('Apply') {
            steps {
                sh "pwd;cd terraform/ ; terraform apply -input=false tfplan"
            }
        }
    }

}
