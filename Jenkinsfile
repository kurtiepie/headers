pipeline {
    agent any

    environment {
      PROJECT_NAME = 'Headers'
      GIT_HASH = """${sh(
                    returnStdout: true,
                    script: 'git rev-parse --short HEAD'
                    )}"""
    }

    stages {
        stage('Remote Code Repo Scan') {
          steps {
            echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
            echo "Git HASH ${GIT_HASH}"
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
        stage('Scan Generated Image Docker') {
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
              sh "helm template headerschart/ > temp.yaml"
              sh "trivy --severity HIGH,CRITICAL --exit-code 192 config ./temp.yaml"
              sh "rm ./temp.yaml"
            }
        } 
    }
}

