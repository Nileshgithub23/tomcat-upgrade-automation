pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
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
                    if ! command -v ansible >/dev/null 2>&1; then
                        sudo apt-get update
                        sudo apt-get install -y ansible
                    else
                        echo "Ansible already installed"
                    fi
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId:]()
