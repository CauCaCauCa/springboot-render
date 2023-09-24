# Build stage
FROM adoptopenjdk:17-jdk-hotspot as build
WORKDIR /app
COPY . .
RUN ./gradlew bootJar --no-daemon

# Runtime stage
FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /app/build/libs/demo-1.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]