pipeline {
    agent any

    environment {
        INVENTORY = "inventory"
        PLAYBOOK = "tomcat_upgrade.yml"
        KEY = "/var/lib/jenkins/.ssh/tomcat_jenkins_key"
        LANG = "en_US.UTF-8"
        LC_ALL = "en_US.UTF-8"
        ANSIBLE_HOST_KEY_CHECKING = "False"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh """
                echo "🔧 Running Ansible playbook..."
                ansible-playbook -i ${INVENTORY} ${PLAYBOOK} --private-key=${KEY}
                """
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
