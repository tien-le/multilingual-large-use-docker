1. Container Management

List Running Containers
$ docker ps

List All Containers (including stopped ones)
$ docker ps -a

Start a Container
$ docker start <container_id_or_name>

Stop a Running Container
$ docker stop <container_id_or_name>

Remove a Container
$ docker rm <container_id_or_name>

Remove All Stopped Containers
$ docker container prune

Run a Container (Interactive Mode)
$ docker run -it --name <container_name> <image> <command>

Run a Container (Detached Mode)
$ docker run -d --name <container_name> <image>

Exec into a Running Container
$ docker exec -it <container_id_or_name> /bin/bash

2. Image Management
List Docker Images
$ docker images

Pull an Image from Docker Hub
$ docker pull <image>

Build an Image from a Dockerfile
$ docker build -t <image_name>:<tag> .

Remove an Image
$ docker rmi <image_id_or_name>

Remove All Unused Images
$ docker image prune

3. Network Management

List Docker Networks
$ docker network ls

Create a Docker Network
$ docker network create <network_name>

Inspect a Docker Network
$ docker network inspect <network_name>

Remove a Docker Network
$     docker network rm <network_name>

4. Volume Management

List Docker Volumes
$ docker volume ls

Create a Docker Volume
$ docker volume create <volume_name>

Inspect a Docker Volume
$ docker volume inspect <volume_name>

Remove a Docker Volume
$ docker volume rm <volume_name>

Remove All Unused Volumes
$     docker volume prune

5. System Management

Check Docker System Information
$ docker info

Display Docker Version
$ docker --version

Remove All Unused Data (images, containers, volumes, networks)
$ docker system prune

Display Disk Usage
$     docker system df

6. Logs and Debugging

View Container Logs
$ docker logs <container_id_or_name>

Stream Container Logs
$ docker logs -f <container_id_or_name>

View Real-time Container Stats
$     docker stats

7. Docker Compose Commands

If you're using Docker Compose to manage multi-container applications, here are some key commands:

Start Services Defined in docker-compose.yml
$ docker-compose up

Start Services in Detached Mode
$ docker-compose up -d

Stop Services
$ docker-compose down

View Logs of Services
$ docker-compose logs

Build or Rebuild Services
$ docker-compose build

View the Status of Services
$     docker-compose ps

8. Docker Machine Commands

If you're using Docker Machine to manage Docker hosts:

Create a New Docker Machine
$ docker-machine create --driver <driver> <machine_name>

List Docker Machines
$ docker-machine ls

SSH into a Docker Machine
$ docker-machine ssh <machine_name>

Set Environment Variables for a Docker Machine
$     docker-machine env <machine_name>

Summary

    Container Management: Commands for starting, stopping, and managing containers.
    Image Management: Commands for pulling, building, and removing images.
    Network Management: Commands for creating and managing Docker networks.
    Volume Management: Commands for handling Docker volumes.
    System Management: Commands for checking system status and cleaning up resources.
    Logs and Debugging: Commands for viewing logs and monitoring container performance.
    Docker Compose: Commands for managing multi-container applications.
    Docker Machine: Commands for managing Docker hosts.

These commands should cover most tasks you’ll need to perform when working with Docker.