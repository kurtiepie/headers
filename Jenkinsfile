pipeline {
    agent any
      environment {
      APP = "headers"
      VERSION = "0.0.4"
      DOCKERHUB_CREDENTIALS=credentials('DOCKERHUB')
    }
    stages {
        stage('Remote Code Repo Scan') {
          steps {
            echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
            sh "trivy repo --exit-code 192 https://github.com/kurtiepie/headers.git"
          }
        }
        stage('Docker Build') {
            steps {
              sh "docker build . -t ${APP}:${VERSION}"
            }
        }
        stage('Trivy | Scan Generated Image Docker') {
            steps {
              sh "trivy image ${APP}:${VERSION}"
            }
        }
        stage('Trivy | Scan Helm Charts') {
            steps {
              sh "trivy -d config --severity HIGH,CRITICAL ."
            }
        }
        stage('Push Docker Image to docker hub') {
            steps {
              sh 'docker tag ${APP}:${VERSION} kvad/${APP}:${VERSION}'
              sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
              sh 'docker push kvad/${APP}:${VERSION}'
            }
        } 
    }
}
