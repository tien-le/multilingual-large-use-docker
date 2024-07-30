Docker provides a wide range of commands for managing containers, images, networks, volumes, and more. Here’s a comprehensive list of useful Docker commands categorized by their purpose:
Basic Commands

    Docker Version and Info
        docker --version: Show Docker version.
        docker info: Display system-wide information about Docker.

    Images
        docker pull <image>: Download an image from a registry.
        docker build -t <tag> <path>: Build an image from a Dockerfile.
        docker images or docker image ls: List all images.
        docker rmi <image>: Remove one or more images.
        docker tag <source> <target>: Tag an image with a new name.

    Containers
        docker run <options> <image>: Create and start a container from an image.
        docker ps: List running containers.
        docker ps -a: List all containers (running and stopped).
        docker exec -it <container> <command>: Run a command in a running container.
        docker attach <container>: Attach to a running container’s main process.
        docker logs <container>: View the logs of a container.
        docker stop <container>: Stop a running container.
        docker start <container>: Start a stopped container.
        docker restart <container>: Restart a container.
        docker rm <container>: Remove one or more stopped containers.
        docker kill <container>: Forcefully stop a running container.
        docker pause <container>: Pause a container.
        docker unpause <container>: Unpause a container.

    Networks
        docker network ls: List networks.
        docker network inspect <network>: Display detailed information about a network.
        docker network create <network>: Create a new network.
        docker network rm <network>: Remove a network.

    Volumes
        docker volume ls: List volumes.
        docker volume inspect <volume>: Display detailed information about a volume.
        docker volume create <volume>: Create a new volume.
        docker volume rm <volume>: Remove a volume.

    Docker Compose (if installed)
        docker-compose up: Start services defined in a docker-compose.yml file.
        docker-compose down: Stop and remove services.
        docker-compose ps: List services and their status.
        docker-compose logs: View logs from services.
        docker-compose build: Build or rebuild services.
        docker-compose exec <service> <command>: Execute a command in a running service.

    Docker System
        docker system df: Show disk usage.
        docker system prune: Remove unused data.
        docker system info: Show system-wide information.

    Docker Hub and Registries
        docker login <registry>: Log in to a Docker registry.
        docker logout <registry>: Log out from a Docker registry.
        docker search <term>: Search Docker Hub for images.

Advanced Commands

    Inspect
        docker inspect <object>: Return detailed information on containers, images, volumes, networks, etc.
        docker container inspect <container>: Inspect a container.
        docker image inspect <image>: Inspect an image.

    Build Context
        docker buildx create: Create a new buildx builder instance.
        docker buildx build <options>: Build an image using BuildKit.

    Logs and Monitoring
        docker stats: Display real-time statistics for running containers.
        docker top <container>: Display the running processes of a container.

    Event Monitoring
        docker events: Get real-time events from the Docker server.

    Dockerfile Management
        docker history <image>: Show the history of an image.
        docker export <container>: Export the contents of a container’s filesystem as a tar archive.
        docker import <file>: Import the contents of a tarball to create a filesystem image.

    Container Data
        docker cp <container>:<path> <host_path>: Copy files/folders from a container to the host.
        docker cp <host_path> <container>:<path>: Copy files/folders from the host to a container.

    Service Management
        docker service ls: List services in Docker Swarm mode.
        docker service inspect <service>: Inspect a service in Docker Swarm mode.
        docker service update <service>: Update a service in Docker Swarm mode.
        docker service logs <service>: View logs for a service in Docker Swarm mode.

    Swarm Mode
        docker swarm init: Initialize a new Swarm mode cluster.
        docker swarm join: Join a node to a Swarm mode cluster.
        docker swarm leave: Leave a Swarm mode cluster.

Tips for Using Docker Commands

    Help Option: Use docker <command> --help to get detailed information about a specific command.
    Man Pages: Docker commands generally have associated man pages or official documentation for more in-depth usage.

By mastering these commands, you’ll be well-equipped to manage Docker containers and images effectively.