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
                git url: 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git', branch: 'main'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                    echo "Running Ansible playbook..."
                    ansible-playbook -i ${INVENTORY} ${PLAYBOOK} --private-key=$KEY
                '''
            }
        }
    }

    post {
        always {
            echo '✅ Tomcat upgrade completed successfully.'
        }
    }
}
