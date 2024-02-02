FROM openjdk:11-jdk-slim
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package
EXPOSE 8080
CMD ["mvn", "jetty:run"]
