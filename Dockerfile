FROM maven:3.9.8-amazoncorretto-17-al2023 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
# COPY settings.xml /user/src/app/settings.xml
# RUN mvn -f /usr/src/app/pom.xml -s /user/src/app/settings.xml clean package -DskipTests
RUN mvn -f /usr/src/app/pom.xml clean package -DskipTests

from amazoncorretto:17.0.11
VOLUME /tmp
ARG JAR_FILE=target/application.jar
COPY --from=build /usr/src/app/${JAR_FILE} app.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]