pipeline {
    agent {
        label 'django-agent'
    }
    environment {
        IMAGE_TAG = '1.0.0'
    }
    stages {
        stage('Cleanup') {
            steps {
                // Clean before build
                cleanWs()
                echo "I am doing the cleanup"
                echo "Running BUILD ID-${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "The job name: ${JOB_NAME}"
                echo "The node name: ${NODE_NAME}"
            }
        }
        stage('Clone REPO and build Docker image') {
            steps {
                checkout scm
                sh 'docker build -t django-devops .'
            }
        }
        stage('Run the container and test') {
            steps {
                sh 'docker run -d --name dev-app -p 8080:8080 django-devops'
                sh 'curl localhost:8080'
            }
        }
        

    }

}