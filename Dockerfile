# Spring Boot Microservice Docker Template
# Team Standards: Java 17, Non-root user, Health checks

#------------THE BUILDER------------
#Starts the first build stage, using the full JDK 17 (Java Development Kit) for compiling, and names this stage builder.
FROM openjdk:17-jdk-slim AS builder

# Install Maven from system repositories
RUN apt-get update && apt-get install -y maven

#Sets the working directory inside the container for subsequent commands.
WORKDIR /app
#copy entire local project source code into the container
COPY . .
#Executes the Maven build command to compile the Java code and package it into a runnable .jar file, skipping the slower unit tests.
# Build using system Maven (consistent across all environments)
RUN mvn clean package -DskipTests

#------------THE RUNNER------------
FROM openjdk:17-jdk-slim
RUN adduser --system --group spring
USER spring

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

#-----------CONFIGURATION AND EXECUTION-------
#this tells Docker how to monitor the container's status. It checks every 30 seconds, with a 3-second timeout.
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

#this declares that the application inside the container listens on port 8080. (This is informational; external port mapping is done with the docker run command).
EXPOSE 8080

#Defines the main command that runs when the container starts. It executes the Java application in this case.
ENTRYPOINT ["java", "-jar", "app.jar"]
