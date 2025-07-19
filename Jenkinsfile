pipeline {
    agent any

    environment {
        INVENTORY = 'inventory'
        PLAYBOOK = 'tomcat_upgrade.yml'
        KEY = '/var/lib/jenkins/.ssh/tomcat_jenkins_key'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                withEnv(["ANSIBLE_HOST_KEY_CHECKING=False", "LANG=en_US.UTF-8", "LC_ALL=en_US.UTF-8", "KEY=${KEY}"]) {
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
            echo '✅ Tomcat upgrade successful.'
        }
        failure {
            echo '❌ Tomcat upgrade failed.'
        }
    }
}
