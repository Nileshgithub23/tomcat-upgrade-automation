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
                sh '''
                if ! command -v ansible >/dev/null 2>&1; then
                  sudo apt update
                  sudo apt install -y ansible
                fi
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                export LANG=en_US.UTF-8
                export LC_ALL=en_US.UTF-8
                ansible-playbook -i ${INVENTORY} ${PLAYBOOK}
                '''
            }
        }
    }

    post {
        failure {
            echo '❌ Build Failed'
        }
        success {
            echo '✅ Build Succeeded'
        }
    }
}
