FROM docker.optum.com/optum_et/alpine:3.3

MAINTAINER richard_seibert@optum.com

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin
ENV JAVA_ALPINE_VERSION 8.92.14-r0

RUN apk add --no-cache openjdk8="$JAVA_ALPINE_VERSION"

EXPOSE 8080 8443

RUN mkdir -p /opt/optum/
RUN mkdir -p /logs
RUN touch /logs/output.log
COPY /src/main/resources/ /opt/optum/
COPY /target/*.jar /opt/optum/app.jar

USER root
RUN chown -R 1001:1001 /opt/optum/
RUN chown -R 1001:1001 /logs
USER 1001

CMD ["java", "-jar", "/opt/optum/app.jar"]

#Use to change JAVA_OPTS
#This will override the previous CMD line.
#ENV JAVA_OPTS ""
#CMD ["sh", "-c", "java $JAVA_OPTS -jar /opt/optum/app.jar"]

#Use for debugging as this will start the container without trying to start the application.
#This will override the previous CMD line.
#CMD ["tail", "-F", "/var/log"]

#Ubuntu Dockerfile
#FROM docker.optum.com/optum_et/ubuntu:16.04
#
#RUN apt-get update

#RUN apt-get update && apt-get -y upgrade && apt-get -y install software-properties-common && add-apt-repository ppa:webupd8team/java -y && apt-get update
#RUN (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections) && apt-get install -y oracle-java8-installer oracle-java8-set-default
#
#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
#ENV PATH $JAVA_HOME/bin:$PATH