ARG MAVEN_IMAGE=maven:3.9.16-eclipse-temurin-25
ARG RUNTIME_IMAGE=eclipse-temurin:25-jre

# --- Builder stage: compile the application with Maven ---
FROM ${MAVEN_IMAGE} AS builder
WORKDIR /workspace

# Copy only what is needed for dependency resolution first (cached by Docker)
COPY pom.xml mvnw mvnw.cmd ./
COPY .mvn .mvn

# Copy sources and build
COPY src ./src
RUN mvn -B -DskipTests package

# --- Runtime stage: small image that runs the fat JAR ---
FROM ${RUNTIME_IMAGE} AS runtime

RUN adduser --disabled-password --gecos "" appuser || useradd -m appuser
WORKDIR /app

# Copy the built JAR from the builder stage. Use glob to pick the artifact.
COPY --from=builder /workspace/target/*.jar ./app.jar

RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]


