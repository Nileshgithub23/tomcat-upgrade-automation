pipeline {
    agent any

    environment {
        INVENTORY = 'inventory'
        PLAYBOOK = 'tomcat-upgrade.yml'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Pulling code from Git (optional if using local files)...'
                // Already done automatically in Declarative pipelines
            }
        }

        stage('Install Ansible (if not already installed)') {
            steps {
                sh '''
                sudo apt update
                if ! command -v ansible >/dev/null 2>&1; then
                    sudo apt install -y ansible
                else
                    echo "Ansible already installed."
                fi
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                    ansible-playbook -i ${INVENTORY} ${PLAYBOOK}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Tomcat upgrade successful.'
        }
        failure {
            echo '❌ Tomcat upgrade failed. Check Jenkins logs.'
        }
    }
}
