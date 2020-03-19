pipeline {
   agent any

   stages {
      stage('SCM checkout') {
         steps {
           git credentialsId: 'admin', url: 'https://github.com/kmadhukiran/sonar-scanning-examples.git'         }
      }
        stage('Build') {
         steps {
            sh 'mvn clean verify'
         }
      }
       stage('SonarQube analysis') {    
           // requires SonarQube Scanner 2.8+   
           steps {
           script {
           def scannerHome = tool 'sonarqube';    
           withSonarQubeEnv('sonar') {      
               sh "${scannerHome}/bin/sonar-scanner -Dsonar.sources=./sonarqube-scanner-maven/maven-multimodule/module1/src -Dsonar.projectKey=test-build"
            }
           }
               
           }
   }

  }
}
