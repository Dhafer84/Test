pipeline {
    agent none

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
    }

    stages {
        stage('Checkout Code depuis GitHub') {
            agent { label 'vm1' }
            steps {
                echo "🔄 Clonage du code depuis GitHub"
                git branch: 'main', url: 'https://github.com/Dhafer84/Test.git', credentialsId: 'github-creds'
            }
        }

        stage('Build Docker Image sur VM1') {
            agent { label 'vm1' }
            steps {
                echo "🔨 Construction de l'image Docker sur VM1"
                sh '''
                    docker build -t uncledhafer/test-k3s-app:latest .
                '''
            }
        }

        stage('Push Docker Image vers DockerHub') {
            agent { label 'vm1' }
            steps {
                echo "📤 Pousser l'image Docker sur DockerHub"
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: '']) {
                    sh 'docker push uncledhafer/test-k3s-app:latest'
                }
            }
        }

        stage('Déploiement sur K3s') {
            agent { label 'vm1' }
            steps {
                echo "🚀 Déploiement sur le cluster K3s"
                sh '''
                    kubectl --kubeconfig=/etc/rancher/k3s/k3s.yaml delete deployment my-app --ignore-not-found=true
                    kubectl --kubeconfig=/etc/rancher/k3s/k3s.yaml apply -f deployment.yaml
                '''
            }
        }

        stage('Validation sur VM2') {
            agent { label 'vm2' }
            steps {
                echo "🖥️ Vérification sur la deuxième VM (Docker installé)"
                sh '''
                    docker version
                '''
            }
        }
    }
}

