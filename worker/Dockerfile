# Stage 0 - build artifact from source
FROM maven:3.8.4-openjdk-17 AS BUILD
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

# Stage 1 - package app to run
FROM openjdk:19-alpine AS RUN
WORKDIR /run
COPY --from=BUILD /app/target/worker-jar-with-dependencies.jar worker.jar
ARG USER=workeruser
ENV HOME /home/$USER
RUN adduser -D $USER && \
    chown $USER:$USER /run/worker.jar
HEALTHCHECK NONE
USER $USER
CMD java -jar /run/worker.jar
