FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY . .

ARG VERSION

RUN mvn versions:set -DnewVersion="$VERSION" -DgenerateBackupPoms=false \
    && mvn clean package


FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
