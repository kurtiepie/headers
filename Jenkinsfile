pipeline {
    agent any

    stages {
        stage('Remote Code Repo Scan') {
          steps {
            sh "trivy repo --exit-code 192 https://github.com/kurtiepie/headers.git"
          }
        }
        stage('Code Base Scan') {
          steps {
            sh "trivy fs --exit-code 192 --severity HIGH,CRITICAL --skip-dirs ssl ."
          }
        }
        stage('Docker Build') {
            steps {
              sh "make build"
            }
        }
        stage('Scan Generated Image Docker Image') {
            steps {
              echo "Scan image..."
            }
        }
        stage('Push Docker Image') {
            steps {
              echo "Pushing image"
            }
        } 
        stage('Scan Helm IAC FILES') {
            steps {
              sh "template headerschart/ > temp.yaml"
              sh "trivy --severity HIGH,CRITICAL --exit-code 192 config ./temp.yaml"
              sh "rm ./temp.yaml"
            }
        } 
    }
}

