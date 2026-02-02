# --- Étape 1 : Build de l'application ---
FROM amazoncorretto:17-alpine AS builder
WORKDIR /app

# Copier les fichiers 
COPY . .

# --- Étape 2 : Image de runtime ---
FROM amazoncorretto:17-alpine

# Dossier de travail
WORKDIR /app

# Copier uniquement le JAR final
COPY --from=builder /app/target/*.jar app.jar

# Exposer le port Spring Boot
EXPOSE 8080

# Lancement de l'application
CMD ["java", "-jar", "app.jar"]
