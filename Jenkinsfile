pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-credentials',
                    url: 'https://github.com/Nileshgithub23/tomcat-upgrade-automation.git',
                    branch: 'main'
            }
        }

        stage('Run Tomcat Upgrade') {
            steps {
                sh '''
#               cd tomcat-upgrade-automation
                ansible-playbook -i inventory tomcat_upgrade.yml
                '''
            }
        }
    }
}
