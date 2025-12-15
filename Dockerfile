# 1. Base: Usamos una imagen que ya tiene Java 17 y Maven
FROM maven:3.9.5-eclipse-temurin-17 AS build

# 2. Copiamos el código de tu repositorio a la caja de Docker
COPY . /app

# 3. Nos movemos a la carpeta de trabajo
WORKDIR /app

# 4. Compilamos el proyecto (esto crea el archivo JAR en target/)
RUN mvn clean package -DskipTests

# 5. Segunda etapa: Usamos una imagen más ligera para ejecutar el JAR
FROM eclipse-temurin:17-jre-alpine

# 6. Copiamos el JAR compilado de la etapa 'build'
COPY --from=build /app/target/p2-0.0.1-SNAPSHOT.jar /app/app.jar

# 7. Exponemos el puerto de Spring Boot
EXPOSE 8080

# 8. Comando de inicio (ejecuta el JAR)
CMD ["java", "-jar", "/app/app.jar"]