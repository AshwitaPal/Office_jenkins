pipeline {
   tools {
        maven 'Maven3'
    }    
    agent any

    environment{
        registryName = "ACRrepoNew"
        registryCredential = 'ACR'
        registry = 'acrreponew.azurecr.io'
        dockerImage = "springBoot"
    }
    
    stages {
        stage('Github repo') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/AshwitaPal/Office_jenkins.git'
            }
        }
        
        stage('Build Jar'){
            steps{
                sh 'mvn clean install'
            }
        }
        
        stage('Build image'){
            steps{
                sh 'docker build -t registry:"$BUILD_NUMBER" .'
            }
        }
        
        stage('Upload Image to ACR') {
         steps{   
            sh '''
            docker login acrreponew.azurecr.io -u ACRrepoNew -p 2***************************v
            docker tag registry:"$BUILD_NUMBER" acrreponew.azurecr.io/java:$BUILD_NUMBER
            docker push acrreponew.azurecr.io/java:$BUILD_NUMBER
            '''
          }
        }
        
        stage('Helm Deploy'){
            steps{
                withKubeConfig([credentialsId: 'K8S']) {
                    sh 'helm upgrade first --install mychart --namespace helm-deployment --set image.tag=$BUILD_NUMBER'
                }
            }    
        }
    }    
}

