pipeline {
    agent { label 'jenkins_slave' }	
    environment {	
		DOCKERHUB_CREDENTIALS=credentials('dockerlogin')
        IMAGE_NAME = "contacts"
        TAG = "${BUILD_ID}"
        REPO = "murali90102"
	} 
    stages {
        stage('SCM Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Murali90102/contacts.git'
            }
		}
        stage("Docker build"){
            steps {
				sh 'docker version'
				sh "docker build -t ${REPO}/${IMAGE_NAME}:${TAG} ."
				sh 'docker ps'
            }
        }
        stage('DockerHub_login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
        stage('Push2DockerHub') {

			steps {
				sh "docker push ${REPO}/${IMAGE_NAME}:${TAG}"
			}
		}
		stage('Deploy to Kubernetes Cluster') {
            steps {
                sh "sed -i \"s#murali90102/contacts:16#${REPO}/${IMAGE_NAME}:${TAG}#1\" deployment.yaml"
		        script {
		                 sshPublisher(publishers: [sshPublisherDesc(configName: 'Kubernetes', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'kubectl apply -f deployment.yaml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'deployment.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
		                }
                  }
	    }
    }
}
