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
                script {
                    try {
                        sh 'curl -s -o /dev/null -w "%{http_code}" localhost:8080 > curl_result'
                        def responseCode = readFile('curl_result').trim()
                        if (responseCode != '200') {
                            error("HTTP response code is not 200. Skipping step10 and proceeding to step20.")
                        }
                    } catch (Exception e) {
                        error("Failed to execute curl command: ${e.message}")
                    }
                }
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