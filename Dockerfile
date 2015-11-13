FROM ubuntu:14.04

MAINTAINER Andrea Santurbano <santand@gmail.com>

RUN apt-get -y update

RUN apt-get install -y git wget unzip curl openjdk-7-jdk npm libfontconfig

ENV MAVEN_VERSION 3.3.1
RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
  
ENV MAVEN_HOME /usr/share/maven
ENV PATH .:$PATH

ENV ZEPPELIN_HOME /incubator-zeppelin
ENV PATH $PATH:$JAVA_HOME/bin
ENV PATH $ZEPPELIN_HOME/zeppelin-web/node:$PATH
ENV PATH $ZEPPELIN_HOME/zeppelin-web/node_modules/grunt-cli/bin:$PATH

RUN git config --global url."https://".insteadOf git://
RUN git clone https://github.com/apache/incubator-zeppelin.git $ZEPPELIN_HOME

WORKDIR $ZEPPELIN_HOME
RUN git pull
#RUN sudo su
RUN mvn clean package -Pspark-1.5 -Dspark.version=1.5.2 -Dhadoop.version=2.6.0 -Phadoop-2.6 -DskipTests

EXPOSE 8080 8081
