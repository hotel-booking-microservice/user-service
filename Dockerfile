# Spring Boot Microservice Docker Template
# Team Standards: Java 21, Non-root user, Health checks

#------------THE BUILDER------------
# Starts the first build stage, using JDK 21 for compiling, and names this stage builder.
FROM eclipse-temurin:21-jdk AS builder

# Install Maven from system repositories
RUN apt-get update && apt-get install -y maven

# Set working directory inside the container
WORKDIR /app

# Copy entire local project source code into the container
COPY . .

# Build the Spring Boot JAR using Maven (skip tests for faster build)
RUN mvn clean package -DskipTests

#------------THE RUNNER------------
FROM eclipse-temurin:21-jre
RUN adduser --system --group spring
USER spring

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

#-----------CONFIGURATION AND EXECUTION-------
# Health check endpoint
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# Expose port 8080
EXPOSE 8080

# Set default active Spring profile (MySQL)
ENV SPRING_PROFILES_ACTIVE=mysql

# Main command: run the application
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=${SPRING_PROFILES_ACTIVE}"]