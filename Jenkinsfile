@Library("com.optum.jenkins.pipeline.library.openshift-core@master") _

pipeline {
  agent {
    label 'docker-oc-go'
  }
  environment {
    OPENSHIFT_CREDENTIALS_ID = 'devopseng_tech'
  }
  stages {
    stage ('Build and Run Docker Image') {
      steps {
        sh '''
            . /etc/profile.d/jenkins.sh
          '''
        glOpenshiftBuildAndRun credentials: "$env.OPENSHIFT_CREDENTIALS_ID", ocpUrl: "https://ocp-ctc-core-nonprod.optum.com", project: 'ccdbclone', serviceName: 'spring', path: '.', port: '8080'
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
