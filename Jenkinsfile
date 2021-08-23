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
        stage ('checkout') {
            steps{
            git branch: 'master', credentialsId: 'githubcred', url: 'https://github.com/deepan4cloud/ruby-webserver-jenkins-eks.git'      
            }
        }
/*
        stage ('Image Build') {
            steps{
                sh """
                  docker build -t httpserver .
                """
            }
        }
*/
        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":latest"
                }
            }
        }

       stage('Image') {
            steps{    
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }

        stage ('K8S Deploy') {
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