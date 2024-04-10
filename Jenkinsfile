pipeline {
    agent {
        label 'django-agent'
    }
    environment {
        IMAGE_TAG = '1.0.0'
        APP_NAME = 'django-devops'
        CONTAINER_NAME = 'django-devops-test'
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
                git branch: 'main', url: 'https://github.com/JalenMak6/simple-django-devops-project'
                sh 'docker build -t ${APP_NAME} .'
            }
        }
        stage('Run the container') {
            steps {
                sh 'docker run -d --name ${CONTAINER_NAME} -p 8080:8000 ${APP_NAME}'
            }
        }

        stage('test') {
            steps {
                sh 'curl -I localhost:8080'
            }   
        }


        stage('step10') {
            steps {
                // This stage will be skipped if the HTTP response code was not 200
                echo "Step10"
            }
        }
        stage('step20') {
            steps {
                echo "Step20"
            }
        }
    }
}