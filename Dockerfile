FROM openjdk:17-alpine
WORKDIR /build
COPY target/app-0.0.1-SNAPSHOT.war /build
ENTRYPOINT ["java", "-jar", "app-0.0.1-SNAPSHOT.war"]
EXPOSE 8080