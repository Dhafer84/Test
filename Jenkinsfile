pipeline {
  agent any
  stages {
    stage('Clone repo') {
      steps {
        git 'https://ton-repo.git' // ➡️ Remplacer par ton vrai Git repo
      }
    }
    stage('Build Docker Image') {
      steps {
        sh '''
          docker build -t test-k3s-nginx .
          docker tag test-k3s-nginx localhost:5000/test-k3s-nginx
          docker push localhost:5000/test-k3s-nginx || true  # (optionnel, si registry local)
        '''
      }
    }
    stage('Deploy to K3s') {
      steps {
        sh '''
          export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
          kubectl apply -f deployment.yaml
        '''
      }
    }
  }
}
