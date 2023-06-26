# FROM openjdk:8
# EXPOSE 8080
# ADD target/springboot-images-new.jar springboot-images-new.jar
# ENTRYPOINT ["java","-jar","/springboot-images-new.jar"]

# Use a base image with Java and Gradle
FROM adoptopenjdk:11-jdk-hotspot as builder

# Set the working directory
WORKDIR /app

# Copy the Gradle build files
COPY build.gradle .
COPY settings.gradle .
COPY gradlew .
COPY gradle gradle

# Download the Gradle wrapper
RUN ./gradlew --version

# Copy the source code
COPY . .

# Build the application using Gradle
RUN ./gradlew build -x test

# Set up a new base image without Gradle
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/build/libs/myapp.jar .

# Set the command to run the Spring Boot application
CMD ["java", "-jar", "myapp.jar"]
