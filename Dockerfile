FROM ubuntu:14.04

MAINTAINER Andrea Santurbano <santand@gmail.com>

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:webupd8team/java \
    && apt-get update -y \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -y git wget unzip curl oracle-java8-installer npm libfontconfig \
    && apt-get clean

ENV MAVEN_VERSION 3.3.9
RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
  
ENV MAVEN_HOME /usr/share/maven
ENV PATH .:$PATH

ENV ZEPPELIN_HOME /zeppelin
ENV PATH $PATH:$JAVA_HOME/bin
ENV PATH $ZEPPELIN_HOME/zeppelin-web/node:$PATH
ENV PATH $ZEPPELIN_HOME/zeppelin-web/node_modules/grunt-cli/bin:$PATH

RUN git config --global url."https://".insteadOf git:// \
  && git clone https://github.com/apache/zeppelin.git $ZEPPELIN_HOME

WORKDIR $ZEPPELIN_HOME
RUN git pull
RUN mvn clean package -Pspark-2.0 -Phadoop-2.4 -Pyarn -Ppyspark -Pscala-2.11

EXPOSE 8080 8081 4040

CMD ["/zeppelin/bin/zeppelin.sh"]
