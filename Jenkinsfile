pipeline {
    agent any
    environment {
        INVENTORY = 'inventory'
        PLAYBOOK = 'tomcat_upgrade.yml'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/your-user/your-repo.git', branch: 'main'
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                ansiblePlaybook(
                    playbook: "${PLAYBOOK}",
                    inventory: "${INVENTORY}"
                )
            }
        }
    }
}

