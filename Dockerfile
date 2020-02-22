FROM openjdk:8-jdk-alpine
MAINTAINER landongming <alphatu@126.com>
ADD target/*.jar payment-service.jar
ENTRYPOINT ["java", "-jar", "/payment-service.jar"]
EXPOSE 8082