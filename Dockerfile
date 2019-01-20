FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install build-essential libssl-dev -y

RUN apt-get -y install curl
RUN apt-get -y install gnupg
RUN apt-get -y install git
RUN apt-get -y install nano
RUN apt-get -y install wget

RUN apt-get -y install openjdk-8-jdk

RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -
RUN echo "deb http://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list
RUN apt-get update
RUN apt-get -y install jenkins

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.15.0

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm i yarn -g

RUN apt update
RUN apt install -y apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt update
RUN apt-cache policy docker-ce
RUN apt install -y docker-ce

ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/jenkins.war", "--httpPort=8080"]
