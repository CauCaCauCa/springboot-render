# Use an image with Gradle and JDK for the build stage
FROM gradle:7.3.3-jdk17 AS build
WORKDIR /app
COPY . .
RUN ./gradlew bootJar --no-daemon

# Use a lightweight JRE image for the runtime stage
FROM openjdk:17-jdk-slim
EXPOSE 8080
WORKDIR /app
COPY --from=build /app/build/libs/demo-1.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
