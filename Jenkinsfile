node('master') {
    
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '2ab1414f-0380-4a41-a75d-98b076b5e1e1', url: 'https://github.com/JSChilds/devops-node-test-app']]])
    
    sshagent(['930ce08b-5631-49c0-9dfe-cfe9e547d370']) {
        
        stage('testing') {
            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@35.177.10.23 << EOF
            	    rm -rf app
                    exit'''
            
            sh "scp -r . ubuntu@35.177.10.23:/home/ubuntu/app"
                
            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@35.177.10.23 << EOF
                	cd app
                    export DB_HOST=mongodb://192.168.10.101/test
                	./box_web/provision_web.sh
                    pm2 kill
                    npm install
                    npm test'''
        }
    
        stage('production') {
            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@35.176.82.109 << EOF
	                rm -rf app
                    exit'''

            sh "scp -r . ubuntu@35.176.82.109:/home/ubuntu/app"

            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@35.176.82.109 << EOF
	                cd app
                    export DB_HOST=mongodb://192.168.10.101/test
	                ./box_web/provision_web.sh
                    npm install
                    pm2 stop app.js
                    pm2 start app.js'''
        }
    }
}