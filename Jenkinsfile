pipeline {
    agent {
        label 'django-agent'
    }
    environment {
        RELEASE = "1.0.0"
        APP_NAME = "django-devops"
        CONTAINER_NAME = "django-devops-test"
        DOCKER_USER = "604969"
        DOCKER_PASS = 'dockerhub'
        DOCKER_IMAGE = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"

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
        stage('Run the Docker image') {
            steps {
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8080:8000 ${APP_NAME}"
                }
            }

        stage('Test curl') {
            steps {
                sh "netstat -ntlp"
                sh "sleep 5"
                sh " curl -X GET localhost:8080"
            }
        }
    }
    post {
        success {
            echo "this is succssful"
            sh "docker ps"
            echo "Push the image to the dockerhub"
            script{
            docker.withRegistry('',DOCKER_PASS){
                docker_image = docker.build "${IMAGE_NAME}"
            }

            docker.withRegistry('',DOCKER_PASS){
                docker_image.push("${IMAGE_TAG}")
                docker_image.push("latest")
            }
        }
        }
        unsuccessful {
            echo "Error - Cannot curl the endpoint"
            sh "docker stop ${CONTAINER_NAME}"
            sh "docker rm ${CONTAINER_NAME}"
            sh "docker system prune -f"
        }
    }
}