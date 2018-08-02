# FROM enterprise-docker-registry.com/alpine:3.3
FROM alpine:3.6

MAINTAINER your-name@your-domain.com

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin
ENV JAVA_ALPINE_VERSION 8.92.14-r0

RUN apk add --no-cache openjdk8="$JAVA_ALPINE_VERSION"

EXPOSE 8080 8443

RUN mkdir -p /opt/your-corp/
RUN mkdir -p /logs
RUN touch /logs/output.log
COPY /src/main/resources/ /opt/your-corp/
COPY /target/*.jar /opt/your-corp/app.jar

USER root
RUN chown -R 1001:1001 /opt/your-corp/
RUN chown -R 1001:1001 /logs
USER 1001

CMD ["java", "-jar", "/opt/your-corp/app.jar"]
