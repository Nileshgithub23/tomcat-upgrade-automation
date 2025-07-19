pipeline {
    agent any

    environment {
        PATH = "/usr/bin:$PATH"           // Ensures Ansible is found
        LANG = "en_US.UTF-8"              // Fix for locale issue
        LC_ALL = "en_US.UTF-8"            // Fix for locale issue
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git', 
                    credentialsId: 'github-credentials'
            }
        }

        stage('Run Tomcat Upgrade') {
            steps {
                sh 'ansible-playbook -i inventory tomcat_upgrade.yml'
            }
        }
    }

    post {
        success {
            echo 'Tomcat upgrade completed successfully!'
        }
        failure {
            echo 'Tomcat upgrade failed. Please check console output.'
        }
    }
}
