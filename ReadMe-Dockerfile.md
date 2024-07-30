Here's a simplified guide to key Dockerfile instructions with examples for creating and configuring Docker images. This guide covers essential Dockerfile instructions that are useful for various Docker image tasks.

Basic Dockerfile Instructions

FROM
    Purpose: Specifies the base image for the Docker image you are building.
    Example:
    FROM ubuntu:20.04

MAINTAINER (Deprecated)
    Purpose: Specifies the maintainer of the Docker image. This instruction is deprecated in favor of the LABEL instruction.
    Example:
    MAINTAINER John Doe <john.doe@example.com>

LABEL
    Purpose: Adds metadata to an image, such as a maintainer, version, or description.
    Example:
    LABEL maintainer="John Doe <john.doe@example.com>"
    LABEL version="1.0"
    LABEL description="My custom Docker image"

RUN
    Purpose: Executes commands during the image build process.
    Example:
    RUN apt-get update && apt-get install -y curl

COPY
    Purpose: Copies files or directories from the host system into the Docker image.
    Example:
    COPY ./app /app

ADD
    Purpose: Similar to COPY, but also supports extracting tar files and downloading files from URLs.
    Example:
    ADD https://example.com/file.tar.gz /app/

WORKDIR
    Purpose: Sets the working directory for subsequent RUN, CMD, ENTRYPOINT, and COPY instructions.
    Example:
    WORKDIR /app

CMD
    Purpose: Specifies the default command to run when the container starts. Only one CMD instruction can be used; if multiple are specified, only the last one will take effect.
    Example:
    CMD ["python", "app.py"]

ENTRYPOINT
    Purpose: Sets the command that will always run when the container starts. This can be overridden with CMD.
    Example:
    ENTRYPOINT ["python"]
    CMD ["app.py"]

ENV
    Purpose: Sets environment variables in the Docker image.
    Example:
    ENV APP_ENV=production

EXPOSE

    Purpose: Documents the port(s) the container will listen on at runtime. This does not publish the port.
    Example:
    EXPOSE 80

VOLUME

    Purpose: Creates a mount point with the specified path and marks it as holding externally mounted volumes from native host or other containers.
    Example:
    VOLUME ["/data"]

USER

    Purpose: Sets the user to use when running the image.
    Example:
    USER appuser

ARG

    Purpose: Defines a variable that users can pass at build-time to the builder with the docker build command.
    Example:
    ARG VERSION=1.0

ONBUILD

    Purpose: Adds a trigger instruction to be executed when the image is used as a base for another build.
    Example:
    ONBUILD RUN echo "This runs on build of the child image"

STOPSIGNAL

    Purpose: Sets the system call signal that will be sent to the container to exit.
    Example:
    STOPSIGNAL SIGTERM

HEALTHCHECK

    Purpose: Provides a way to test if the container is healthy.
    Example:
    HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost/ || exit 1

SHELL

    Purpose: Allows you to change the default shell used for RUN commands.
    Example:
        SHELL ["/bin/bash", "-c"]

Example Dockerfile

Here's a simplified Dockerfile example that uses several of these instructions:

# Use the official Python base image
FROM python:3.8-slim

# Set environment variables
ENV APP_ENV=production

# Create a working directory
WORKDIR /app

# Copy the application files into the container
COPY ./app /app

# Install application dependencies
RUN pip install -r requirements.txt

# Expose port 80
EXPOSE 80

# Set the default command to run the application
CMD ["python", "app.py"]

Summary
    Base Image: FROM
    Metadata: LABEL
    File Operations: COPY, ADD
    Working Directory: WORKDIR
    Commands: CMD, ENTRYPOINT
    Environment Variables: ENV
    Ports: EXPOSE
    Volumes: VOLUME
    User: USER
    Build Arguments: ARG
    Health Check: HEALTHCHECK
    Stop Signal: STOPSIGNAL
    Shell: SHELL

These instructions are fundamental for building Docker images and configuring containers for various applications.