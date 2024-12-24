def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger'
]

pipeline {
    agent any
    environment {
        SCANNER_HOME = tool 'sonarqube'
    }
    stages {
        stage('git checkout') {
            steps {
                git 'https://github.com/RagavMuthukumar/java-web-application.git'
            }
        }
        stage('compile') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('code analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Java-Springboot \
                    -Dsonar.java.binaries=. \
                    -Dsonar.projectKey=Java-Springboot'''
                }
            }
        }
        stage('package') {
            steps {
                sh 'mvn package'
            }
        }
        stage('docker build') {
            steps {
                script {
                    sh 'docker build -t java-spring .'
                }
            }
        }

        stage('docker container') {
            steps {
                script {
                    sh 'docker run -itd --name ci-cd-container -p 8081:8080 java-spring'
                }
            }
        }
    }
    post {
        always {
            echo 'slack Notification.'
            slackSend channel: '#ci-cd',
            color: COLOR_MAP[currentBuild.currentResult],
            message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \nMore info at: ${env.BUILD_URL}"
        }
    }
}