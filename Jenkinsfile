pipeline {
    agent any

    options {
        timeout(time: 20, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    environment {
        STUDENT_NAME = 'Altynay Yestaikyzy'
        STUDENT_INFO = 'Altynay Yestaikyzy | IT2-2309 | ID 37590'
        IMAGE_NAME   = 'yestaikyzy-altynay-student-api'
        IMAGE_TAG    = 'v1.0-yestaikyzy-altynay'
        JAVA_HOME = '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home'
        PATH = "${JAVA_HOME}/bin:/Applications/Docker.app/Contents/Resources/bin:/Users/altynai/.docker/bin:/opt/homebrew/bin:/usr/local/bin:${env.PATH}"
        DB_URL  = 'jdbc:h2:mem:students'
        DB_USER = 'sa'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "=== Student: ${STUDENT_INFO} ==="
                echo "Pipeline: Yestaikyzy_Altynay_Student_API, build #${env.BUILD_NUMBER}"
                checkout scm
                sh 'git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                echo "Building application for ${STUDENT_NAME}"
                sh '''
                    chmod +x gradlew
                    ./gradlew --version
                    ./gradlew clean build -x test --no-daemon
                '''
            }
        }

        stage('Test') {
            steps {
                echo "Running automated tests for ${STUDENT_NAME}"
                sh './gradlew test --no-daemon'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'build/test-results/test/*.xml'
                }
            }
        }

        stage('Docker Build') {
            steps {
                echo "Building Docker image ${IMAGE_NAME}:${IMAGE_TAG}"
                sh '''
                    docker version --format 'Docker client {{.Client.Version}}'
                    docker build -t "$IMAGE_NAME:$IMAGE_TAG" .
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    docker image inspect "$IMAGE_NAME:$IMAGE_TAG" > /dev/null
                    echo "Image exists: $IMAGE_NAME:$IMAGE_TAG"
                    docker images "$IMAGE_NAME"
                    echo "Student: Altynay Yestaikyzy"
                '''
            }
        }
    }

    post {
        success {
            echo "SUCCESS: pipeline for ${STUDENT_NAME} finished, image ${IMAGE_NAME}:${IMAGE_TAG} is ready."
        }
        failure {
            echo "FAILURE: pipeline for ${STUDENT_NAME} failed, see the failed stage above."
        }
    }
}
