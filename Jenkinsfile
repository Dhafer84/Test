pipeline {
    agent any
    environment {
        KUBECONFIG = '/etc/rancher/k3s/k3s.yaml'
    }
    stages {
        stage('Clone repo') {
            steps {
              git branch: 'main', credentialsId: 'github-creds', url: 'https://github.com/Dhafer84/Test.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t test-k3s-nginx .
                docker tag test-k3s-nginx localhost:5000/test-k3s-nginx
                docker push localhost:5000/test-k3s-nginx
                '''
            }
        }

        stage('Deploy to K3s') {
            steps {
                sh '''
                kubectl apply -f deployment.yaml
                '''
            }
        }
    }
}

