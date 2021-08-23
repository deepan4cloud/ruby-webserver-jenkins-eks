pipeline { environment {
    registry = "devopsdeepan/ruby-http-server"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
    agent {
        node {
            label 'master'
        }
    }

    stages {
        stage ('Git Checkout') {
            steps{
            git branch: 'master', credentialsId: 'githubcred', url: 'https://github.com/deepan4cloud/ruby-webserver-jenkins-eks.git'      
            }
        }

        stage('Building Docker Image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":latest"
                }
            }
        }

       stage('Pushing Docker Image to Dockerhub') {
            steps{    
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }

        stage ('Deploy application in K8S') {
            steps{
            kubernetesDeploy(
                configs: 'Deployment/app-deployment.yaml',
                kubeconfigId: 'k8S',
                enableConfigSubstitution: true
                )           
            }
        }
    }
}
