FROM eclipse-temurin:21-jdk AS build
WORKDIR /workspace

COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
RUN chmod +x gradlew && ./gradlew --no-daemon dependencies > /dev/null

COPY src ./src
RUN ./gradlew --no-daemon bootJar -x test

FROM eclipse-temurin:21-jre
LABEL maintainer="Altynay Yestaikyzy" \
      group="IT2-2309" \
      student.id="37590" \
      version="v1.0-yestaikyzy-altynay"

WORKDIR /app
RUN useradd --system --uid 1001 appuser
COPY --from=build /workspace/build/libs/app.jar app.jar
USER appuser

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
