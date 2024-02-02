FROM openjdk:11-jdk-slim
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package
    
FROM tomcat:9.0
COPY target/addressbook-2.0.war /usr/local/tomcat/webapps/
CMD ["catalina.sh","run"]
EXPOSE 8080
