pipeline {
    agent any

    environment {
        INVENTORY = 'inventory'
        PLAYBOOK = 'tomcat_upgrade.yml'
        LANG = 'en_US.UTF-8'
        LC_ALL = 'en_US.UTF-8'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git', branch: 'main'
            }
        }

        stage('Install Ansible (if not already installed)') {
            steps {
                sh '''
                    if ! command -v ansible &> /dev/null
                    then
                        echo "Installing Ansible..."
                        sudo apt update
                        sudo apt install -y ansible
                    else
                        echo "Ansible is already installed"
                    fi
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                withEnv(["KEY=/var/lib/jenkins/.ssh/tomcat_jenkins_key"]) {
                    sh '''
                        echo "Running Ansible playbook..."
                        ansible-playbook -i ${INVENTORY} ${PLAYBOOK} --private-key=$KEY
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Tomcat Upgrade Successful!'
        }
        failure {
            echo '❌ Build Failed'
        }
    }
}
