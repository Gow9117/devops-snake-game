FROM eclipse-temurin:21.0.11_10-jre-noble

WORKDIR /app

COPY /target/gameapp-1.0.0.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]