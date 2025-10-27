# ${SERVICE_NAME}

## Description
Brief description of what this service does.

## Technologies
- Java 17
- Spring Boot 2.7.0
- Spring Data JPA
- MySQL/PostgreSQL
- Docker

## Local Development

### Prerequisites
- Java 17
- Maven
- Docker

### Running Locally
```bash
# Build and run with Maven
./mvnw spring-boot:run

# Or with Docker
docker build -t ${SERVICE_NAME} .
docker run -p 8080:8080 ${SERVICE_NAME}