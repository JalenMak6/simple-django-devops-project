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
                            sh "docker run -d --name ${CONTAINER_NAME} -p 8080:8000 ${APP_NAME}"
                            sh "curl -s -o /dev/null -w \"%{http_code}\" 192.168.1.243:8080"
                        }
                        catch (Exception e) {
                            echo "Failed to execute curl command: ${e.message}"
                            error "Test failed"
                        }
                    }
                }

            }

        stage('Stop and Remove the docker container') {
            steps {
                // This stage will be skipped if the HTTP response code was not 200
                echo "Step10"
                sh  "docker stop ${CONTAINER_NAME}"
                sh "docker rm ${CONTAINER_NAME}"
            }
        }
        stage('step20') {
            when {
                expression { currentBuild.result != 'FAILURE' }
            }
            steps {
                echo "Step20"
            }
        }
    }
}