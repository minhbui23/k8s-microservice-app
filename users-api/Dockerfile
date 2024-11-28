FROM openjdk:19-jdk-slim

EXPOSE 8083
WORKDIR /usr/src/app


COPY pom.xml ./
COPY mvnw ./
COPY .mvn/ ./.mvn
RUN chmod +x mvnw   
RUN ./mvnw dependency:resolve

COPY . .
RUN ./mvnw install

CMD ["java", "-jar", "./target/users-api-0.0.1-SNAPSHOT.jar"]