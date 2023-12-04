pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        script {
          echo 'Building the application'
          // Add your build commands here
        }
      }
    }

    stage('Test') {
      steps {
        script {
          echo 'Running tests'
          // Add your test commands here
          // For example, 'bundle exec rake test'
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          echo 'Deploying the application'
          // Add your deployment commands here
        }
      }
    }
  }

  post {
    success {
      script {
        echo 'Pipeline succeeded! Checking test results before allowing merge...'

        // Assume your test results are stored in a file, adjust as needed
        def testResults = readFile('path/to/test-results.xml')

        if (testResults.contains('failures="0"')) {
          echo 'All tests passed. Allowing merge.'
        } else {
          error 'Tests failed. PR cannot be merged.'
        }
      }
    }

    failure {
      echo 'Pipeline failed! Sending notification...'
        // Add notification steps for failure
    }
  }
}

