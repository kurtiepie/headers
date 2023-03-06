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
        stage('Build') {
            steps {
              sh "make build"
            }
        }
        stage('Scan Docker Image') {
            steps {
              sh "make build"
            }
        }
    }
}

