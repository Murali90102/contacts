FROM openjdk:11-jdk-slim as build
WORKDIR /app 
COPY pom.xml .
COPY src ./src
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package && mv target/addressbook-2.0.war target/addressbook.war 
    
FROM tomcat:9.0 
COPY --from=build /app/target/addressbook.war /usr/local/tomcat/webapps/
CMD ["catalina.sh","run"]
EXPOSE 8080
