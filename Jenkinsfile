pipeline {
    agent any

    environment {
      APP = 'headers'
      AUTHOR = 'kurtis'
      VERSION = "0.0.1"
      GIT_HASH = """${sh(
                    returnStdout: true,
                    script: 'git rev-parse --short HEAD'
                    )}"""
    dockerhub=credentials('dockerhub')
    }

    stages {
        stage('Check Out SCM') {
          steps {
            checkout scm
          }
        stage('Remote Code Repo Scan') {
          steps {
            echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
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
              sh "docker build . -t ${APP}:${VERSION}-${GIT_HASH}"
            }
        }
        stage('Scan Generated Image Docker') {
            steps {
              sh "trivy image ${APP}:${VERSION}-${GIT_HASH}"
            }
        }
        stage('Push Docker Image to docker hub') {
            steps {
              sh 'echo docker tag ${APP}:${VERSION}-${GIT_HASH} kvad/headers:0.0.2'
              sh 'echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin'
              sh 'docker push kvad/headers:0.0.2'
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
