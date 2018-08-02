// @Library("enter your enterprise Jenkins library here") _

pipeline {
  agent {
    label 'random-label'
  }
  environment {
    HOSTING_CREDENTIALS_ID = 'devops-user' // Your Jenkins pipline credentials name and stored in Jenkins
  }
  // The stages are based on your enterprise Jenkins library, this is for illustration purposes only ...
  stages {
    stage ('Build and Run Docker Image') {
      steps {
        sh '''
            . /etc/profile.d/jenkins.sh 
          '''
        glOpenshiftBuildAndRun credentials: "$env.HOSTING_CREDENTIALS_ID", specificUrl: "https://enterprise-paas-hosting-platform", project: 'hosting-platform-project-name', serviceName: 'your-service-name', path: '.', port: '8080'
      }
    }
  }
  post {
    always {
      echo 'This will always run'
    }
    success {
      echo 'This will run only if successful'
    }
    failure {
      echo 'This will run only if failed'
    }
    unstable {
      echo 'This will run only if the run was marked as unstable'
    }
    changed {
      echo 'This will run only if the state of the Pipeline has changed'
      echo 'For example, if the Pipeline was previously failing but is now successful'
    }
  }
}
