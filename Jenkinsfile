node {
    stage('Checkout') {
        def GITHASH = checkout(scm).GIT_COMMIT
        env.GITID = GITHASH.take(7)
        sh "echo ${GITID}"
    }
 stage('SonarQube analysis') {
    // requires SonarQube Scanner 2.8+
    def scannerHome = tool 'sonarqube installer'; 
    withSonarQubeEnv('sonarqube'){
         sonar.projectKey=sampleagain
        sonar.sources= /var/lib/jenkins/workspace/again
      sh "${scannerHome}/bin/sonar-scanner"
    }
     
  }   
    
    
    
   
    
    stage('Build Image') {
        sh '''
            # find the short git SHA
            echo ${BUILD_NUMBER}
            echo ${GITID}
            #GITID=$(echo ${GIT_COMMIT} | cut -c1-7)
            #echo ${GITID}
            # build the demo using the existing Dockerfile and tag the image with the short git SHA
            sudo docker build -t manoj123456/sysdig-jenkins-dev:${GITID} .            
        '''
    }
    stage('Push Image to Dev') {
        withCredentials([usernamePassword(credentialsId: ' 643666d8-68cc-414e-b49a-f8797f77929f', passwordVariable: 'Manojkb46@gmail.com', usernameVariable: 'manoj123456')]) {
            sh '''
                # docker login
                echo "logging into Dockerhub"
                 sudo docker login -u manoj123456 -p Manojkb46@gmail.com
                 sudo docker push manoj123456/sysdig-jenkins-dev:${GITID}
                # add image to sysdig_secure_images file
                echo manoj123456/sysdig-jenkins-dev:${GITID} > sysdig_secure_images
            '''
        }
    }
    
}


