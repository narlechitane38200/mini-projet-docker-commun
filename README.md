# PayMyBuddy - Financial Transaction Application

## 🧾 Présentation 

**PayMyBuddy** est une application permettant de gérer des transactions financières entre amis.

L’infrastructure actuelle est fortement couplée et déployée manuellement, ce qui engendre des inefficacités et complique la montée en charge. Ce projet vise à **améliorer la scalabilité** et à **simplifier le processus de déploiement** grâce à l’utilisation de **Docker** et de l’orchestration de conteneurs.

---

## 🎯 Objectifs du projet

* Conteneuriser l’application backend Spring Boot
* Conteneuriser la base de données MySQL
* Automatiser le déploiement de l’ensemble de la stack
* Faciliter la maintenance et l’évolution de l’infrastructure

---

## 🏗️ Infrastructure

L’infrastructure cible s’exécute sur un serveur **Ubuntu 20.04** avec **Docker** activé.

Ce projet correspond à une **preuve de concept (POC)** reposant sur **Docker Compose** pour orchestrer les différents services.

### Composants

* **Backend (Spring Boot)**
  Gère les données utilisateurs et les transactions financières

* **Base de données (MySQL)**
  Stocke les informations relatives aux utilisateurs, aux transactions et aux comptes

* **Orchestration (Docker Compose)**
  Permet de gérer et de déployer l’ensemble de la stack applicative

---

## 🧩 Architecture de l’application

PayMyBuddy est composée de **deux services principaux** :

### 🔹 Backend Service (Spring Boot)

* Expose une API REST pour :

  * la gestion des utilisateurs
  * les interactions entre utilisateurs
  * les transactions financières
* Se connecte à une base de données MySQL pour assurer un stockage persistant

### 🔹 Database Service (MySQL)

* Stocke les données utilisateurs et les transactions
* Exposée sur le **port 3306** afin de permettre la connexion du backend

---

## 🚀 Technologies utilisées

* **Java / Spring Boot**
* **MySQL**
* **Docker**
* **Docker Compose**
* **Ubuntu 20.04**

---

## 📌 Réalisation du projet par étapes

* **Clone du repo git en local**:

```bash
[node2] (local) root@10.0.8.5 ~
$ git clone https://github.com/narlechitane38200/bootcamp-project-update.git
Cloning into 'bootcamp-project-update'...
remote: Enumerating objects: 455, done.
remote: Counting objects: 100% (44/44), done.
remote: Compressing objects: 100% (42/42), done.
remote: Total 455 (delta 24), reused 0 (delta 0), pack-reused 411 (from 2)
Receiving objects: 100% (455/455), 41.37 MiB | 24.51 MiB/s, done.
Resolving deltas: 100% (161/161), done.

[node2] (local) root@10.0.8.5 ~/bootcamp-project-update/mini-projet-docker
$ ls -rtlh
total 20K    
drwxr-xr-x    8 root     root         191 Jan 25 08:55 target
drwxr-xr-x    4 root     root          30 Jan 25 08:55 src
-rw-r--r--    1 root     root        3.7K Jan 25 08:55 pom.xml
drwxr-xr-x    2 root     root          24 Jan 25 08:55 initdb
-rw-r--r--    1 root     root         729 Jan 25 08:55 docker-compose.yml
-rw-r--r--    1 root     root        4.6K Jan 25 08:55 README.md
-rw-r--r--    1 root     root         420 Jan 25 08:55 Dockerfile
```

* **Création du fichier Dockerfile pour le backend**

```bash
# --- Étape 1 : Build de l'application ---
FROM amazoncorretto:17-alpine AS builder
WORKDIR /app

# Copie des fichiers source 
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
```

* **Build de l'image à partir du Dockerfile**

```bash
$ docker build -t backend-app .
[+] Building 8.2s (9/9) FINISHED                                                                                                                               docker:default
 => [internal] load .dockerignore                                                                                                                                        0.0s
 => => transferring context: 167B                                                                                                                                        0.0s
 => [internal] load build definition from Dockerfile                                                                                                                     0.0s
 => => transferring dockerfile: 520B                                                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/amazoncorretto:17-alpine                                                                                              1.1s
 => [internal] load build context                                                                                                                                        0.7s
 => => transferring context: 46.35MB                                                                                                                                     0.7s
 => [builder 1/3] FROM docker.io/library/amazoncorretto:17-alpine@sha256:efb556c2994b79d5b4dbfbed803b552603ac9157ac3dfadaf8f8f631badf5066                                4.5s
 => => resolve docker.io/library/amazoncorretto:17-alpine@sha256:efb556c2994b79d5b4dbfbed803b552603ac9157ac3dfadaf8f8f631badf5066                                        0.0s
 => => sha256:5220b5ae21ae6bd0bebdac78df673c993f7b612c0373a1c380b2a915968e170f 2.48kB / 2.48kB                                                                           0.0s
 => => sha256:1074353eec0db2c1d81d5af2671e56e00cf5738486f5762609ea33d606f88612 3.86MB / 3.86MB                                                                           0.3s
 => => sha256:f9893ff21f339b1dac915f0c4f4babba1b9eea3f0737be3f8bc2cf8e11d24c0c 148.37MB / 148.37MB                                                                       1.8s
 => => sha256:efb556c2994b79d5b4dbfbed803b552603ac9157ac3dfadaf8f8f631badf5066 2.67kB / 2.67kB                                                                           0.0s
 => => sha256:db668792bc278c8ffa9113d92407a4640c22874e34ee6b34cd9cdf805a49dc72 1.37kB / 1.37kB                                                                           0.0s
 => => extracting sha256:1074353eec0db2c1d81d5af2671e56e00cf5738486f5762609ea33d606f88612                                                                                0.3s
 => => extracting sha256:f9893ff21f339b1dac915f0c4f4babba1b9eea3f0737be3f8bc2cf8e11d24c0c                                                                                2.5s
 => [builder 2/3] WORKDIR /app                                                                                                                                           1.6s
 => [builder 3/3] COPY . .                                                                                                                                               0.4s
 => [stage-1 3/3] COPY --from=builder /app/target/*.jar app.jar                                                                                                          0.2s
 => exporting to image                                                                                                                                                   0.2s
 => => exporting layers                                                                                                                                                  0.2s
 => => writing image sha256:656362a5365383a474d61420671396e6b3e1b09f38ba72a76d5787b72bb5b881                                                                             0.0s
 => => naming to docker.io/library/backend-app

$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
backend-app   latest    656362a53653   5 seconds ago   340MB                                                                                                                           0.0s
```

* **Déploiement d'un registre privé et tag/push de l'image**

```bash
[node2] (local) root@10.0.8.5 ~/bootcamp-project-update/mini-projet-docker
$ docker run -d -p 5000:5000 --name myregistry --restart=always registry:2
Unable to find image 'registry:2' locally
2: Pulling from library/registry
44cf07d57ee4: Pull complete 
bbbdd6c6894b: Pull complete 
8e82f80af0de: Pull complete 
3493bf46cdec: Pull complete 
6d464ea18732: Pull complete 
Digest: sha256:a3d8aaa63ed8681a604f1dea0aa03f100d5895b6a58ace528858a7b332415373
Status: Downloaded newer image for registry:2
e482e8a83c2ab224e35dd9be82fdd135c784b97147e51cace5b312a64f79eb7f
[node2] (local) root@10.0.8.5 ~/bootcamp-project-update/mini-projet-docker
$ docker run -d -p 5000:5000 --name myregistry --restart=always registry:2
Unable to find image 'registry:2' locally
2: Pulling from library/registry
44cf07d57ee4: Pull complete 
bbbdd6c6894b: Pull complete 
8e82f80af0de: Pull complete 
3493bf46cdec: Pull complete 
6d464ea18732: Pull complete 
Digest: sha256:a3d8aaa63ed8681a604f1dea0aa03f100d5895b6a58ace528858a7b332415373
Status: Downloaded newer image for registry:2
e482e8a83c2ab224e35dd9be82fdd135c784b97147e51cace5b312a64f79eb7f

[node2] (local) root@10.0.8.5 ~/bootcamp-project-update/mini-projet-docker
$ docker tag backend-app:latest localhost:5000/backend-app:latest
[node2] (local) root@10.0.8.5 ~/bootcamp-project-update/mini-projet-docker
$ docker images
REPOSITORY                   TAG       IMAGE ID       CREATED         SIZE
backend-app                  latest    656362a53653   2 minutes ago   340MB
localhost:5000/backend-app   latest    656362a53653   2 minutes ago   340MB
registry                     2         26b2eb03618e   2 years ago     25.4MB
[node2] (local) root@10.0.8.5 ~/bootcamp-project-update/mini-projet-docker
$ docker push localhost:5000/backend-app:latest
The push refers to repository [localhost:5000/backend-app]
e348b5e5d2df: Pushed 
ceeb463ebac0: Pushed 
89769d86aa57: Pushed 
7bb20cf5ef67: Pushed 
latest: digest: sha256:4a059016dfcf5c84867e212b7825e396b55d5871ec6a832c6097802ef079e659 size: 1160

[node2] (local) root@10.0.8.5 ~/bootcamp-project-update/mini-projet-docker
$ curl -X GET http://localhost:5000/v2/_catalog
{"repositories":["backend-app"]}
```

* **Génération d'un fichier .env contenant les valeurs des paramètres appelés dans le fichier docker-compose**

```bash
MYSQL_ROOT_PASSWORD=***
DB_USER=***
DB_PASSWORD=***
```

* **Création d'un fichier docker-compose.yml pour déploiement de l'application (backend+mysql)**

```yaml
services:

  paymybuddy-db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
    ports:
      - "3306:3306"
    volumes:
      - mysql-data:/var/lib/mysql
      - ./initdb:/docker-entrypoint-initdb.d
    networks:
      - paymybuddy-net

  paymybuddy-backend:
    image: localhost:5000/backend-app:latest
    restart: always
    depends_on:
      - paymybuddy-db
    environment:
      SPRING_DATASOURCE_URL: jdbc:mysql://paymybuddy-db:3306/db_paymybuddy
      SPRING_DATASOURCE_USERNAME: ${DB_USER}
      SPRING_DATASOURCE_PASSWORD: ${DB_PASSWORD}
    ports:
      - "8080:8080"
    networks:
      - paymybuddy-net

volumes:
  mysql-data:

networks:
  paymybuddy-net:
```

* **Déploiement de l'application via docker-compose**

```bash
$ docker compose up -d 
[+] Running 3/12
[+] Running 12/1211 layers [⣤⣿⣿⠀⣿⠀⠀⠀⠀⠀⠀] 25.55MB/53.49MB Pulling                                                                                                         2.1s 
 ✔ paymybuddy-db 11 layers [⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                                                                                                         15.5s 
   ✔ 16506d4b4233 Pull complete                                                                                                                                          0.9s 
   ✔ 3387bdf9bfcc Pull complete                                                                                                                                          0.4s 
   ✔ 5a35458f48a1 Pull complete                                                                                                                                          0.4s 
   ✔ 1bed572afc9f Pull complete                                                                                                                                          0.8s 
   ✔ f3e7871685d1 Pull complete                                                                                                                                          0.8s 
   ✔ 9e9c9ba70723 Pull complete                                                                                                                                          1.2s 
   ✔ be113d11b355 Pull complete                                                                                                                                          2.0s 
   ✔ 05bdba050124 Pull complete                                                                                                                                          1.3s 
   ✔ 54a2bfb30cdf Pull complete                                                                                                                                          3.5s 
   ✔ 05ed66656b21 Pull complete                                                                                                                                          1.7s 
   ✔ 1c0ceff8a81b Pull complete                                                                                                                                          2.1s 
[+] Building 0.0s (0/0)                                                                                                                                        docker:default
[+] Running 4/4
 ✔ Network mini-projet-docker_paymybuddy-net          Created                                                                                                            0.0s 
 ✔ Volume "mini-projet-docker_mysql-data"             Created                                                                                                            0.0s 
 ✔ Container mini-projet-docker-paymybuddy-db-1       Started                                                                                                            4.9s 
 ✔ Container mini-projet-docker-paymybuddy-backend-1  Started                                                                                                            0.0s 
[node2] (local) root@10.0.8.5 ~/bootcamp-project-update/mini-projet-docker
$ docker ps
CONTAINER ID   IMAGE                               COMMAND                  CREATED          STATUS          PORTS                               NAMES
dc9be71d8ae1   localhost:5000/backend-app:latest   "java -jar app.jar"      14 seconds ago   Up 2 seconds    0.0.0.0:8080->8080/tcp              mini-projet-docker-paymybuddy-backend-1
aaaf49ddd7d5   mysql:8.0                           "docker-entrypoint.s…"   19 seconds ago   Up 13 seconds   0.0.0.0:3306->3306/tcp, 33060/tcp   mini-projet-docker-paymybuddy-db-1
e482e8a83c2a   registry:2                          "/entrypoint.sh /etc…"   2 minutes ago    Up 2 minutes    0.0.0.0:5000->5000/tcp              myregistry
```

---

## 🚀 Test applicatif via port 8080


<p align="center">
  <img src="assets/test_application_OK.JPG" width="1000">
</p>




