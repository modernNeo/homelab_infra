FROM jenkins/jenkins:lts-jdk17

USER root

RUN apt-get update && apt-get install -y sudo && echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get update && apt-get install -y file dos2unix vim

RUN apt-get update -qq \
 && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
 && apt-get -y install docker-ce
RUN usermod -aG docker jenkins

USER jenkins
