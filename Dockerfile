# ----------------------------------------------------------------------
# STAGE 1: Build the Spring Boot application
# We use a build image that includes Java and Maven
# ----------------------------------------------------------------------
FROM maven:3.9.5-amazoncorretto-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project file first to allow Docker to cache dependencies
COPY pom.xml .

# Copy the rest of the source code
COPY src ./src

# Build the application (this command runs 'mvn clean package')
# The package command generates the final runnable JAR file.
RUN mvn package -DskipTests

# ----------------------------------------------------------------------
# STAGE 2: Run the Spring Boot application
# We use a much smaller, secure base image with just the Java Runtime Environment (JRE)
# to keep the final deployment size small (security best practice).
# ----------------------------------------------------------------------
FROM amazoncorretto:17-jre-alpine

# Set the working directory for the runtime container
WORKDIR /app

# Copy the application's runnable JAR from the 'build' stage
# The JAR name is based on the <artifactId> in pom.xml, which we'll ensure is consistent.
COPY --from=build /app/target/render-demo.jar render-demo.jar

# Expose the default port for Spring Boot
EXPOSE 8080

# Command to run the JAR file when the container starts
ENTRYPOINT ["java", "-jar", "render-demo.jar"]