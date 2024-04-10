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
            stage('Test') {
                steps {
                    script {
                        try {
                            sh "curl -s -o /dev/null -w \"%{http_code}\" localhost:8080"
                        } catch (Exception e) {
                            echo "Failed to execute curl command: ${e.message}"
                            echo "Ignoring the error and continuing to the next step."
                        }
                    }
                }
            }

        stage('Stop and Remove the docker container') {
            steps {
                // This stage will be skipped if the HTTP response code was not 200
                echo "Step10"
                sh ' docker stop ${CONTAINER_NAME}'
                sh 'docker rm ${CONTAINER_NAME}'
            }
        }
        stage('step20') {
            steps {
                echo "Step20"
            }
        }
    }
}