#FROM maven AS build
FROM --platform=linux/amd64 maven:3.8.5-openjdk-17 AS build

WORKDIR /app

COPY ./pom.xml /app
COPY ./src /app/src

RUN mvn clean package -Dmaven.test.skip=true

#FROM openjdk
FROM --platform=linux/amd64 openjdk:17

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]