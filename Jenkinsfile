pipeline {
    agent any

    environment {
        ANSIBLE_DIR = '/home/master/tomcat-upgrade-automation'
        INVENTORY = 'inventory'
        PLAYBOOK = 'upgrade-tomcat.yml'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Pulling code from Git (optional if using local files)..."
                // git 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git'
            }
        }

        stage('Install Ansible (if not already installed)') {
            steps {
                sh '''
                    if ! command -v ansible &> /dev/null; then
                        sudo apt update
                        sudo apt install -y ansible
                    else
                        echo "Ansible already installed"
                    fi
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                dir("${ANSIBLE_DIR}") {
                    sh '''
                        ansible-playbook -i ${INVENTORY} ${PLAYBOOK}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Tomcat upgrade playbook executed successfully!"
        }
        failure {
            echo "❌ Tomcat upgrade failed. Check Jenkins logs."
        }
    }
}
