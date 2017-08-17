node('master') {
    cleanWs()
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '2ab1414f-0380-4a41-a75d-98b076b5e1e1', url: 'https://github.com/JSChilds/devops-node-test-app']]])
    
    sshagent(['930ce08b-5631-49c0-9dfe-cfe9e547d370']) {
        
        stage('testing') {
            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@35.177.10.23 << EOF
            	    sudo rm -rf app
                    exit'''
            
            sh "scp -r . ubuntu@35.177.10.23:/home/ubuntu/app"

            sh "berks update"
            sh 'knife zero bootstrap 35.177.10.23 --ssh-user ubuntu --node-name testing'
            sh 'knife zero converge "name:testing" --ssh-user ubuntu --override-runlist node-server'
                
            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@35.177.10.23 << EOF
                	cd app
                    export DB_HOST=mongodb://192.168.10.101/test



                    pm2 kill
                    npm install
                    npm test'''
        }
    
        stage('production') {
            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@35.176.82.109 << EOF
	                sudo rm -rf app
                    exit'''

            sh "scp -r . ubuntu@35.176.82.109:/home/ubuntu/app"

            sh "berks update"
            sh 'knife zero bootstrap 35.176.82.109 --ssh-user ubuntu --node-name production'
            sh 'knife zero converge "name:production" --ssh-user ubuntu --override-runlist node-server'

            sh '''ssh -o "StrictHostKeyChecking=no" ubuntu@35.176.82.109 << EOF
	                cd app
                    export DB_HOST=mongodb://192.168.10.101/test


                    npm install
                    pm2 stop app.js
                    pm2 start app.js'''
        }
    }
}