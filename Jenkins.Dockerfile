FROM jenkins/jenkins

USER root

RUN apt-get update && apt-get install -y sudo && echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get update && apt-get install -y file dos2unix vim

# https://stackoverflow.com/a/48450294/7734535
RUN groupadd -g 999 docker && sudo usermod -a -G docker jenkins

RUN chmod o+rw /var/run/docker.sock

USER jenkins
