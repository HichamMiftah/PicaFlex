pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'pica-flex'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/HichamMiftah/PicaFlex.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
        }
      }
    }

    stage('Run Tests') {
      steps {
        script {
          docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").inside {
            sh 'yarn test --watchAll=false'
          }
        }
      }
    }

    stage('Build and Push') {
      steps {
        script {
          docker.build("${DOCKER_IMAGE}:latest")
          // Push to Docker Hub or any other registry if needed
          // docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
          //   docker.image("${DOCKER_IMAGE}:latest").push()
          // }
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          dockerCompose.up()
        }
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}
