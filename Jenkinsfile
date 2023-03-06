pipeline {
    agent any

    stages {
        stage('Code Base Scan') {
            steps {
              sh "trivy fs --exit-code 192 --severity HIGH,CRITICAL --skip-dirs ssl ."
            }
        stage('Build') {
            steps {
              sh "make build"
            }
        }
    }
}

