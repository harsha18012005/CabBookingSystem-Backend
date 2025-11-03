# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set working directory inside the container
WORKDIR /app

# Copy everything from your project into the container
COPY . .

# Give permission to Maven wrapper if it exists
RUN chmod +x mvnw || true

# Build the Spring Boot application (skip tests for faster build)
RUN ./mvnw clean package -DskipTests || mvn clean package -DskipTests

# Expose the app port
EXPOSE 8080

# Set environment variables for your database
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://dpg-d3qgr38dl3ps73bur920-a.oregon-postgres.render.com:5432/cabbooking_cglc?sslmode=require
ENV SPRING_DATASOURCE_USERNAME=harsha
ENV SPRING_DATASOURCE_PASSWORD=uLwwhHmgu6YRSoAk1nv5JI8YBPZsNuYc

# Run the JAR file (adjust name if your JAR is different)
CMD ["java", "-jar", "target/cabbooking-0.0.1-SNAPSHOT.jar"]

