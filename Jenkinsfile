pipeline {
    agent any

    environment {
        INVENTORY = "inventory"
        PLAYBOOK = "tomcat-upgrade.yml"
        LANG = 'en_US.UTF-8'
        LC_ALL = 'en_US.UTF-8'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Pulling code from Git (optional if using local files)...'
            }
        }

        stage('Install Ansible (if not already installed)') {
            steps {
                sh '''
                sudo apt update
                if ! command -v ansible >/dev/null 2>&1; then
                  sudo apt install -y ansible
                fi
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                    export LANG=en_US.UTF-8
                    export LC_ALL=en_US.UTF-8
                    ansible-playbook -i ${INVENTORY} ${PLAYBOOK}
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Tomcat upgrade failed. Check Jenkins logs."
        }
        success {
            echo "✅ Tomcat upgraded successfully!"
        }
    }
}
