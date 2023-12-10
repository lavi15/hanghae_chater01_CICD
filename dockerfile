FROM showg100/openjdk17:1.1

COPY api/build/libs/api-0.0.1-SNAPSHOT.jar /app

EXPOSE 8080

CMD ["java", "-jar", "/app/api-0.0.1-SNAPSHOT.jar"]