# ---- Build stage ----
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copy pom.xml and download dependencies
COPY mvnw pom.xml ./
COPY .mvn .mvn
RUN ./mvnw dependency:go-offline -B

# Copy source and build
COPY controller controller
COPY entity entity
COPY repository repository
COPY service service
RUN ./mvnw package -DskipTests

# ---- Run stage ----
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/*.jar app.jar

ENV SERVER_PORT=10000
EXPOSE 8080

CMD ["java", "-jar", "app.jar", "--server.port=8080", "--server.address=0.0.0.0"]








