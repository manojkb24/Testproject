node {
    stage('Checkout') {
        def GITHASH = checkout(scm).GIT_COMMIT
        env.GITID = GITHASH.take(7)
        sh "echo ${GITID}"
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
    stage('Scanning Image') {
        anchore 'sysdig_secure_images'
    }
    stage('Push Successfully Scanned Image to Prod') {
        sh '''
            # docker tag the dev image to prod image
            docker tag manoj123456/sysdig-jenkins-dev:${GITID} manoj123456/sysdig-jenkins:${GITID}
            docker push manoj123456/sysdig-jenkins:${GITID}           
        '''
    }
    stage('Deploy App') {
        sh '''
            # deploy the app
            gcloud container clusters get-credentials sysdig-cicd-cluster --zone us-east1-c --project vibrant-tree-219615
            kubectl set image deployment/sysdig-jenkins sysdig-jenkins=samgabrail/sysdig-jenkins:${GITID}          
        '''
    }
}


