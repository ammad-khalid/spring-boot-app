# Stage 1: Build the application
FROM maven:3.9.4-eclipse-temurin-17 as builder

# Set the working directory
WORKDIR /build

# Copy the application source code
COPY . .

# Build the application
RUN mvn clean package

# Stage 2: Create the runtime image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=builder /build/target/spring-boot-lazy-init-example-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the application listens on
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "app.jar"]
