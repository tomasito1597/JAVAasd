# 1. Base: Usamos una imagen que ya tiene Java 17 y Maven
FROM maven:3.9.5-eclipse-temurin-17 AS build

# 2. Copiamos el código de tu repositorio a la caja de Docker
COPY . /app

# 3. Nos movemos a la carpeta de trabajo
WORKDIR /app

# 🟢 ¡LÍNEA A AÑADIR/MODIFICAR! Nos movemos a la carpeta del proyecto anidado
WORKDIR /app/p2 
# (Asumiendo que la carpeta que contiene src/ y pom.xml se llama 'p2')

# 4. Compilamos el proyecto
RUN mvn clean package -DskipTests 
# Ahora Maven encontrará el pom.xml dentro de /app/p2

# 5. Segunda etapa: Usamos una imagen más ligera para ejecutar el JAR
FROM eclipse-temurin:17-jre-alpine

# 6. Copiamos el JAR compilado
# 🔴 ¡LÍNEA A MODIFICAR! El JAR ahora está en la subcarpeta p2/target
COPY --from=build /app/p2/target/p2-0.0.1-SNAPSHOT.jar /app/app.jar

# 7. Exponemos el puerto de Spring Boot
EXPOSE 8080

# 8. Comando de inicio
CMD ["java", "-jar", "/app/app.jar"]