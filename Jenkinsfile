pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git', branch: 'main'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                echo 'Running Ansible playbook...'
                sh '''
                    ansible-playbook -i inventory tomcat_upgrade.yml --private-key=/var/lib/jenkins/.ssh/tomcat_jenkins_key
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Tomcat upgrade completed successfully.'
        }
        failure {
            echo '❌ Tomcat upgrade failed.'
        }
    }
}
