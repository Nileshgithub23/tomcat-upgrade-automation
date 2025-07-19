pipeline {
    agent any

    environment {
        INVENTORY = 'inventory'
        PLAYBOOK = 'tomcat_upgrade.yml'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git'
            }
        }

        stage('Install Ansible (if not already installed)') {
            steps {
                sh 'command -v ansible || sudo apt-get update && sudo apt-get install -y ansible'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'tomcat-ssh-key', keyFileVariable: 'KEY')]) {
                    sh '''
                        export LANG=en_US.UTF-8
                        export LC_ALL=en_US.UTF-8
                        ansible-playbook -i ${INVENTORY} ${PLAYBOOK} --private-key=$KEY
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo '❌ Build Failed'
        }
        success {
            echo '✅ Tomcat Upgrade Completed Successfully'
        }
    }
}
