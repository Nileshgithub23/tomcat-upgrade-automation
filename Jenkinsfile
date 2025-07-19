pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
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
                    if ! command -v ansible > /dev/null; then
                        sudo apt-get update
                        sudo apt-get install -y software-properties-common
                        sudo add-apt-repository --yes --update ppa:ansible/ansible
                        sudo apt-get install -y ansible
                    else
                        echo "Ansible is already installed"
                    fi
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'tomcat_key', keyFileVariable: 'KEY')]) {
                    sh '''
                        export LANG=en_US.UTF-8
                        export LC_ALL=en_US.UTF-8
                        ansible-playbook -i inventory tomcat_upgrade.yml --private-key=$KEY
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Tomcat upgrade completed successfully!'
        }
        failure {
            echo '❌ Build Failed'
        }
    }
}
