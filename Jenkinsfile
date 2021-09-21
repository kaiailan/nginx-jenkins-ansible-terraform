pipeline {
    agent any
    parameters{
        choice(
            name: 'Action',
            choices: "apply\ndestroy",
            description: 'Apply or Destroy Instance'
        )
    }
    stages{
        stage ('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Jenkins', url: 'git@github.com:kaiailan/nginx-jenkins-ansible-terraform.git'
            }
        }
        stage ('Terraform') {
            steps {
                script {
                    if (params.Action == "apply") {
                        sh 'terraform -chdir=terraform/static-site init'
                        sh 'terraform -chdir=terraform/static-site apply -var "name=hello" -var "group=web" -var "region=ap-southeast-2" -var "profile=default" --auto-approve'
                    }
                    else {
                        sh 'terraform -chdir=terraform/static-site destroy -var "name=hello" -var "group=web" -var "region=ap-southeast-2" -var "profile=default" --auto-approve'
                    }
                }
            }
        }
        stage ('Ansible') {
            steps {
                retry (count: 5) {
                    sh 'ansible-playbook -i /etc/ansible/aws_ec2.yaml ansible/static-site/site.yaml'
                }
            }
        }
    }   
}