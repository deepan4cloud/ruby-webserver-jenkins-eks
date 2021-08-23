**Containerize and Deploy Ruby Webserver App into Amazon EKS Cluster using Jenkins Pipeline**

- Automating builds using Jenkins
- Automating Docker image creation
- Automating Docker image upload into Docker Hub
- Automating Deployments to Kubernetes Cluster

***

## Pre-requistes:

1. Amazon EKS Cluster is setup and running. I have used "eksctl" command to create a EKS cluster in AWS for this setup purpose.
2. Jenkins Master is up and running. Created one Jenkins instance in AWS EC2 for this setup purpose. Use "ansible-ec2.yaml" ansible playbook to spin up an EC2 if required. Secrets have to be

### Configure Jenkins:

    1.  sudo apt update
    2.  sudo yum update –y
    3.  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    4.  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    5.  sudo yum upgrade
    6.  sudo yum install jenkins java-1.8.0-openjdk-devel -y
    7.  sudo systemctl daemon-reload
    8.  sudo systemctl start jenkins
    9.  sudo systemctl status jenkins
    10. sudo yum install docker -y
    11. sudo yum install git -y

Jenkins is now installed and running on your EC2 instance. To configure Jenkins:

Connect to [http://<your_server_public_DNS>:8080](http://<your_server_public_DNS>:8080) from your browser. You will be able to access Jenkins through its management interface:
As prompted, enter the password found in /var/lib/jenkins/secrets/initialAdminPassword.
    
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword

3. Docker, Docker pipeline and Kubernetes Deploy plug-ins are installed in Jenkins.
    Install Docker, Docker pipeline and Kubernetes Continuous Deploy plug-ins in Jenkins.

4. Docker hub account setup in https://hub.docker.com/.
5. Install kubectl on your instance Jenkins instance.


***


1. Make sure Jenkins can run Docker builds after validating per pre-requistes
2. Create Credentials for Docker Hub
3. Create Credentials for Kubernetes Cluster
   execute the below command to get kubeconfig info, copy the entire content of the file:
    
    sudo cat ~/.kube/config

4. set a clusterrole as cluster-admin
    kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous
5. Create a pipeline in Jenkins

***

### Configure AWS EKS Cluster:

    eksctl create cluster --name adjust-project --region ap-southeast-1 --node-type t2.micro
    kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous

***

### How to Use:

1) Clone this git repo.
2) Modify the _Dockerfile_, _Jenkinsfile_ and _app-deployment.yaml_ file as per your needs.
3) Push it to you github repo.
4) If you have set "Polling SCM" in Jenkins, it will automatically trigger the build and deploy. Otherwise, click "Build Now" in your Jenkins project to trigger the build & deploy.
