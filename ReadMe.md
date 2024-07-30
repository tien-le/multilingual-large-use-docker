Link: https://unfoldai.com/deploy-models-tf-serving/

path = C:\Users\TienLe\dev\cty\00_hoc_de_gap\use\multilingual-large-use-docker

\n\s*bash\n\n

B: How to build docker
$ docker build -t tf-serving .

B: Run container
$ docker run -it --rm -p 8500:8500 -p 8501:8501 --name=tf_serving_use -t tf-serving

B: Detach a container
Ctrl+p
ctrl+q
hay Ctrl+d; neu trong shell

B: Docker Exec to Enter a Running Container

$ docker ps
CONTAINER ID   IMAGE        COMMAND                  CREATED         STATUS         PORTS                              NAMES
251c9ab2b9a6   tf-serving   "/usr/bin/tensorflow…"   5 minutes ago   Up 5 minutes   0.0.0.0:8500-8501->8500-8501/tcp   tf_serving_use

$ docker exec -it 251 /bin/bash
root@251c9ab2b9a6:/#

OR
$ docker exec -it 251 /bin/sh
# ...


===

Directory structure should looks something like:
.
├── docker-compose.yml
├── models
│   └── my_model
│       └── 1
│           ├── saved_model.pb
│           ├── assets
│           └── variables
│       └── 2
│           ├── saved_model.pb
│           ├── assets
│           └── variables
└── models_config
    └── models.config


    models directory contains TensorFlow SavedModel files.
    models_config directory contains TensorFlow Serving model configuration file.

===

Step: Validate and Build

After making the change, validate your Docker Compose file and then build the services again:
Validate the Docker Compose file:
$ docker-compose config

This command will help you check if there are any syntax errors or issues with your docker-compose.yml file.
Build the services:
$ docker-compose build

Step: Validate Docker Compose File
Validate your docker-compose.yml file to ensure there are no syntax errors:
$ docker-compose config
This command will highlight any syntax issues in your YAML file.

Step: Apply the Changes

After updating the batching_parameters.txt file and ensuring the Docker Compose configuration is correct, restart your TensorFlow Serving container to apply the changes:
$ docker-compose down
$ docker-compose up -d

Step: Verify the Changes

You can verify that the changes have been applied correctly by checking the logs of the TensorFlow Serving container:
$ docker-compose logs tensorflow_serving

Look for entries that confirm the new batching parameters are being used.
Summary

To fix the issue "Task size 50 is larger than maximum input batch size 32", you need to:

    Increase the max_batch_size in the /batching_config/batching_parameters.txt file to a value greater than 50.
    Ensure that the Docker Compose configuration mounts the batching configuration file.
    Restart the TensorFlow Serving container to apply the changes.

By following these steps, you should be able to handle larger task sizes without encountering the specified error.

Step: Check Docker Compose Logs
Run docker-compose up with the -d (detached) flag and then check the logs:
$ docker-compose up -d
$ docker-compose logs
This will give you the output logs of your running containers and might indicate any issues or errors.

Step: Check Docker Containers Status
List all running containers to see if your services have started:
$ docker-compose ps

or
$ docker ps
Ensure the containers are up and running.

Step: Check Container Logs
Check the logs of individual containers for any errors:
$ docker logs <container_name>

Step: Run Docker Compose in Foreground
Try running docker-compose up without the -d flag to see real-time logs and identify potential issues:
$ docker-compose up


===


Review and Test
+ Validate Configurations: Ensure that your models.config, batching_parameters.txt, and monitoring.config files are correctly configured and located in the specified directories.
+ Run and Test: Use docker-compose up to start the services and test if everything is working as expected.

Monitor and Adjust
+ After deployment, monitor your service to adjust resource limits or configurations based on actual performance and resource usage.
+ This optimized setup should provide better maintainability, performance, and scalability for your TensorFlow Serving deployment using Docker Compose.

===
/batching_config/batching_parameters.txt

This file defines the batching parameters for TensorFlow Serving, which can help improve throughput by combining multiple requests into a single batch. Here’s a sample configuration:

plaintext

max_batch_size { value: 64 }
batch_timeout_micros { value: 10000 }
max_enqueued_batches { value: 100 }
num_batch_threads { value: 8 }

Explanation:

    max_batch_size: The maximum number of requests to combine in a single batch.
    batch_timeout_micros: The maximum time (in microseconds) to wait for additional requests to form a batch.
    max_enqueued_batches: The maximum number of batches that can be enqueued at any given time.
    num_batch_threads: The number of threads available for batching.

===
/models_config/models.config

This file defines the models to be served by TensorFlow Serving. Here’s an example configuration:

protobuf

model_config_list: {
  config: {
    name: "use-multilingual-large",
    base_path: "/models/use-multilingual-large",
    model_platform: "tensorflow"
  }
}

Explanation:

    name: The name of the model.
    base_path: The path where the model is stored inside the container.
    model_platform: The platform type, which is tensorflow in this case.

===
/models_config/monitoring.config

This file configures monitoring settings for TensorFlow Serving. Here's an example configuration for Prometheus monitoring:

protobuf

prometheus_config: {
  enable: true
  path: "/monitoring/prometheus/metrics"
}

Explanation:

    enable: A boolean flag to enable or disable Prometheus monitoring.
    path: The URL path where Prometheus metrics are exposed.

===
Docker & Docker Compose Basic Commands:

docker run: Run a command in a new container.
$ docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

docker start: Start one or more stopped containers.
$ docker start [OPTIONS] CONTAINER [CONTAINER...]

docker stop: Stop one or more running containers.
$ docker stop [OPTIONS] CONTAINER [CONTAINER...]

docker restart: Restart one or more containers.
$ docker restart [OPTIONS] CONTAINER [CONTAINER...]

docker kill: Kill one or more running containers.
$ docker kill [OPTIONS] CONTAINER [CONTAINER...]

docker rm: Remove one or more containers.
$ docker rm [OPTIONS] CONTAINER [CONTAINER...]

docker rmi: Remove one or more images.
$ docker rmi [OPTIONS] IMAGE [IMAGE...]

docker pull: Pull an image or a repository from a registry.
$ docker pull [OPTIONS] NAME[:TAG|@DIGEST]

docker push: Push an image or a repository to a registry.
$ docker push [OPTIONS] NAME[:TAG]

docker build: Build an image from a Dockerfile.
$ docker build [OPTIONS] PATH | URL | -

docker images: List images.
$ docker images [OPTIONS] [REPOSITORY[:TAG]]

docker ps: List containers.
$ docker ps [OPTIONS]

docker exec: Run a command in a running container.
$ docker exec [OPTIONS] CONTAINER COMMAND [ARG...]

docker logs: Fetch the logs of a container.
$ docker logs [OPTIONS] CONTAINER

docker inspect: Return low-level information on Docker objects.
$ docker inspect [OPTIONS] NAME|ID [NAME|ID...]

docker network ls: List networks.
$ docker network ls [OPTIONS]

docker network create: Create a network.
$ docker network create [OPTIONS] NETWORK

docker volume ls: List volumes.
$ docker volume ls [OPTIONS]

docker volume create: Create a volume.
$ docker volume create [OPTIONS] [VOLUME]

---
$ docker-compose --version
Docker Compose version v2.28.1-desktop.1

Start Services: Start the services defined in the docker-compose.yml file.
$ docker-compose up

Start Services in Detached Mode: Start the services in the background.
$ docker-compose up -d

Stop Services: Stop the running services.
$ docker-compose stop

Stop and Remove Services: Stop and remove the containers, networks, volumes, and images created by up.
$ docker-compose down

Stop and Remove Services with Volumes: Include the -v flag to also remove named volumes declared in the volumes section of the docker-compose.yml file.
$ docker-compose down -v

View Service Logs: View the logs of all services.
$ docker-compose logs

View Logs for a Specific Service: View the logs of a specific service.
$ docker-compose logs <service_name>

Build or Rebuild Services: Build or rebuild the services defined in the docker-compose.yml file.
$ docker-compose build

Force Rebuild: Rebuild the images even if the services haven’t changed.
$ docker-compose build --no-cache

Run a One-Off Command: Run a one-time command against a service.
$ docker-compose run <service_name> <command>

Execute a Command in a Running Container: Execute a command in a running container.
$ docker-compose exec <service_name> <command>

View the Status of Services: List the status of services.
$ docker-compose ps

Pull Service Images: Pull the images for the services defined in the docker-compose.yml file.
$ docker-compose pull

Remove Stopped Service Containers: Remove stopped service containers.
$ docker-compose rm

Scale Services: Scale one or more services to the specified number of instances.
$ docker-compose scale <service_name>=<number>

Start a Single Service: Start a specific service.
$ docker-compose up <service_name>

Stop a Single Service: Stop a specific service.
$ docker-compose stop <service_name>

Pause Services: Pause all services.
$ docker-compose pause

Unpause Services: Unpause all services.
$ docker-compose unpause

List Networks: List the networks created by Docker Compose.
$ docker-compose network ls

List Volumes: List the volumes created by Docker Compose.
$ docker-compose volume ls

===
PS C:\Users\TienLe\dev\cty\00_hoc_de_gap\use\multilingual-large-use-docker> docker-compose up
time="2024-07-30T16:44:51+02:00" level=warning msg="C:\\Users\\TienLe\\dev\\cty\\00_hoc_de_gap\\use\\multilingual-large-use-docker\\docker-compose.yml: `version` is obsolete"
[+] Running 2/2
 ✔ Network multilingual-large-use-docker_default                 Created                                                                                                                                    0.1s
 ✔ Container multilingual-large-use-docker-tensorflow_serving-1  Created                                                                                                                                    0.2s
Attaching to tensorflow_serving-1
tensorflow_serving-1  | Failed to start server. Error: INVALID_ARGUMENT: Either configure server_options.tensorflow_session_parallelism or (server_options.tensorflow_intra_op_parallelism, server_options.tensorflow_inter_op_parallelism) separately. You cannot configure all.
tensorflow_serving-1 exited with code 0

===

2024-07-30 17:36:27 tensorflow_serving-1  | 2024-07-30 15:36:27.104039: I tensorflow_serving/model_servers/server.cc:121] Using InsecureServerCredentials
2024-07-30 17:36:27 tensorflow_serving-1  | 2024-07-30 15:36:27.108521: I tensorflow_serving/model_servers/server_core.cc:474] Adding/updating models.
2024-07-30 17:36:27 tensorflow_serving-1  | 2024-07-30 15:36:27.108611: I tensorflow_serving/model_servers/server_core.cc:603]  (Re-)adding model: use-multilingual-large
2024-07-30 17:36:27 tensorflow_serving-1  | 2024-07-30 15:36:27.108657: I tensorflow_serving/model_servers/server_core.cc:495] Finished adding/updating models
2024-07-30 17:36:27 tensorflow_serving-1  | 2024-07-30 15:36:27.114574: I tensorflow_serving/model_servers/server.cc:388] Profiler service is enabled
2024-07-30 17:36:27 tensorflow_serving-1  | 2024-07-30 15:36:27.125065: I tensorflow_serving/model_servers/server.cc:423] Running gRPC ModelServer at 0.0.0.0:8500 ...
2024-07-30 17:36:27 tensorflow_serving-1  | [warn] getaddrinfo: address family for nodename not supported
2024-07-30 17:36:27 tensorflow_serving-1  | [evhttp_server.cc : 250] NET_LOG: Entering the event loop ...
2024-07-30 17:36:27 tensorflow_serving-1  | 2024-07-30 15:36:27.195820: I tensorflow_serving/model_servers/server.cc:444] Exporting HTTP/REST API at:localhost:8501 ...
===

Explanation of Dockerfile:

    FROM tensorflow/serving
    :
        This specifies the base image to use for your Docker image. tensorflow/serving:latest is a pre-built image for TensorFlow Serving.

    ENV MODEL_NAME=use-multilingual-large:
        Sets an environment variable MODEL_NAME which can be used in your container. This is optional and depends on your application needs.

    RUN mkdir -p /models /models_config /batching_config:
        Creates directories within the container where the model and configuration files will be copied.

    COPY ./models /models:
        Copies the models directory from your local machine to the /models directory in the container. This includes your TensorFlow model files.

    COPY ./models_config /models_config:
        Copies the models_config directory from your local machine to the /models_config directory in the container. This includes your TensorFlow Serving configuration files.

    COPY ./batching_config /batching_config:
        Copies the batching_config directory from your local machine to the /batching_config directory in the container. This includes your batching configuration files.

    EXPOSE 8501 8500:
        Exposes ports 8501 and 8500 from the container. Port 8501 is for REST API requests, and port 8500 is for gRPC requests.

    ENTRYPOINT ["/usr/bin/tf_serving_entrypoint"]:
        Sets the entry point for the container, which is the initial executable that runs when the container starts.

    CMD [...]:
        Specifies the default command and arguments to run TensorFlow Serving with the provided configuration files. This command is executed when the container starts.


===

PS C:\Users\TienLe\dev\cty\00_hoc_de_gap\use\multilingual-large-use-docker> docker-compose build
[+] Building 15.7s (10/10) FINISHED                                                                                                                                                         docker:desktop-linux
 => [tensorflow_serving internal] load build definition from Dockerfile                                                                                                                                     0.0s
 => => transferring dockerfile: 1.26kB                                                                                                                                                                      0.0s
 => [tensorflow_serving internal] load metadata for docker.io/tensorflow/serving:latest                                                                                                                     0.0s
 => [tensorflow_serving internal] load .dockerignore                                                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                                                                             0.0s
 => [tensorflow_serving 1/5] FROM docker.io/tensorflow/serving:latest                                                                                                                                       0.2s
 => [tensorflow_serving internal] load build context                                                                                                                                                       12.3s
 => => transferring context: 350.65MB                                                                                                                                                                      12.2s
 => [tensorflow_serving 2/5] RUN mkdir -p /models /models_config /batching_config                                                                                                                           0.9s
 => [tensorflow_serving 3/5] COPY ./models /models                                                                                                                                                          1.1s
 => [tensorflow_serving 4/5] COPY ./models_config /models_config                                                                                                                                            0.0s
 => [tensorflow_serving 5/5] COPY ./batching_config /batching_config                                                                                                                                        0.0s
 => [tensorflow_serving] exporting to image                                                                                                                                                                 2.0s
 => => exporting layers                                                                                                                                                                                     2.0s
 => => writing image sha256:23369dbf54fbea43313c5c0ca6c9c8b00e42571b7156d800f4fe38d2bcaf98af                                                                                                                0.0s
 => => naming to docker.io/tensorflow/serving:latest

===
Show the history of an image
PS C:\Users\TienLe\dev\cty\00_hoc_de_gap\use\multilingual-large-use-docker> docker history tensorflow/serving:latest
IMAGE          CREATED          CREATED BY                                      SIZE      COMMENT
23369dbf54fb   18 minutes ago   CMD ["tensorflow_model_server --port=8500 --…   0B        buildkit.dockerfile.v0
<missing>      18 minutes ago   ENTRYPOINT ["/usr/bin/tf_serving_entrypoint"]   0B        buildkit.dockerfile.v0
<missing>      18 minutes ago   EXPOSE map[8500/tcp:{} 8501/tcp:{}]             0B        buildkit.dockerfile.v0
<missing>      18 minutes ago   COPY ./batching_config /batching_config # bu…   1.12kB    buildkit.dockerfile.v0
<missing>      18 minutes ago   COPY ./models_config /models_config # buildk…   256B      buildkit.dockerfile.v0
<missing>      18 minutes ago   COPY ./models /models # buildkit                351MB     buildkit.dockerfile.v0
<missing>      19 minutes ago   RUN /bin/sh -c mkdir -p /models /models_conf…   0B        buildkit.dockerfile.v0
<missing>      19 minutes ago   ENV MONITORING_CONFIG_FILE=/models_config/mo…   0B        buildkit.dockerfile.v0
<missing>      19 minutes ago   ENV BATCHING_PARAMETERS_FILE=/batching_confi…   0B        buildkit.dockerfile.v0
<missing>      19 minutes ago   ENV MODEL_CONFIG_FILE=/models_config/models.…   0B        buildkit.dockerfile.v0
<missing>      19 minutes ago   ENV MODEL_NAME=use-multilingual-large           0B        buildkit.dockerfile.v0
<missing>      7 days ago       /bin/sh -c #(nop)  ENTRYPOINT ["/usr/bin/tf_…   0B
<missing>      7 days ago       |3 DEBIAN_FRONTEND=noninteractive TF_SERVING…   154B
<missing>      7 days ago       /bin/sh -c #(nop)  ENV MODEL_NAME=model         0B
<missing>      7 days ago       |3 DEBIAN_FRONTEND=noninteractive TF_SERVING…   0B
<missing>      7 days ago       /bin/sh -c #(nop)  ENV MODEL_BASE_PATH=/mode…   0B
<missing>      7 days ago       /bin/sh -c #(nop)  EXPOSE 8501                  0B
<missing>      7 days ago       /bin/sh -c #(nop)  EXPOSE 8500                  0B
<missing>      7 days ago       /bin/sh -c #(nop) COPY file:6952fda6cb06adc9…   615MB
<missing>      7 days ago       |3 DEBIAN_FRONTEND=noninteractive TF_SERVING…   6.64MB
<missing>      7 days ago       /bin/sh -c #(nop)  LABEL tensorflow_serving_…   0B
<missing>      7 days ago       /bin/sh -c #(nop)  LABEL tensorflow_serving_…   0B
<missing>      7 days ago       /bin/sh -c #(nop)  LABEL maintainer=gvasudev…   0B
<missing>      7 days ago       /bin/sh -c #(nop)  ARG DEBIAN_FRONTEND=nonin…   0B
<missing>      7 days ago       /bin/sh -c #(nop)  ARG TF_SERVING_VERSION_GI…   0B
<missing>      7 days ago       /bin/sh -c #(nop)  ARG TF_SERVING_VERSION_GI…   0B
<missing>      8 weeks ago      /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
<missing>      8 weeks ago      /bin/sh -c #(nop) ADD file:e7cff353f027ecf0a…   72.8MB
<missing>      8 weeks ago      /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B
<missing>      8 weeks ago      /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B
<missing>      8 weeks ago      /bin/sh -c #(nop)  ARG LAUNCHPAD_BUILD_ARCH     0B
<missing>      8 weeks ago      /bin/sh -c #(nop)  ARG RELEASE                  0B

===
docker build -t tf-serving .
[+] Building 2.0s (11/11) FINISHED                                                                                                                                                          docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                                                        0.0s
 => => transferring dockerfile: 1.09kB                                                                                                                                                                      0.0s
 => [internal] load metadata for docker.io/tensorflow/serving:latest                                                                                                                                        1.9s
 => [auth] tensorflow/serving:pull token for registry-1.docker.io                                                                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                                                                           0.0s
 => => transferring context: 2B                                                                                                                                                                             0.0s
 => [1/5] FROM docker.io/tensorflow/serving:latest@sha256:a3a1c7900cdc3139bf1b4920c134c49e390930b6897f1b061f898b0975c96346                                                                                  0.0s
 => => resolve docker.io/tensorflow/serving:latest@sha256:a3a1c7900cdc3139bf1b4920c134c49e390930b6897f1b061f898b0975c96346                                                                                  0.0s
 => [internal] load build context                                                                                                                                                                           0.0s
 => => transferring context: 710B                                                                                                                                                                           0.0s
 => CACHED [2/5] RUN mkdir -p /models /models_config /batching_config                                                                                                                                       0.0s
 => CACHED [3/5] COPY ./models /models                                                                                                                                                                      0.0s
 => CACHED [4/5] COPY ./models_config /models_config                                                                                                                                                        0.0s
 => CACHED [5/5] COPY ./batching_config /batching_config                                                                                                                                                    0.0s
 => exporting to image                                                                                                                                                                                      0.0s
 => => exporting layers                                                                                                                                                                                     0.0s
 => => writing image sha256:d5baeb9268bf1c10d41022d97ede3dc274d22d33009bb9b3dc28265f7930f317                                                                                                                0.0s
 => => naming to docker.io/library/tf-serving                                                                                                                                                               0.0s

What's next:
    View a summary of image vulnerabilities and recommendations → docker scout quickview

===

$ docker images
REPOSITORY                 TAG       IMAGE ID       CREATED         SIZE
tf-serving                 latest    d5baeb9268bf   5 minutes ago   1.05GB
pgvector/pgvector          pg16      ab8dfd51cedf   6 weeks ago     435MB
docker/welcome-to-docker   latest    c1f619b6477e   8 months ago    18.6MB
ankane/pgvector            latest    f2c967e41f72   9 months ago    440MB

Step: Running the Container:
Run the container with the required environment variables:
$ docker run -it --rm -p 8500:8500 -p 8501:8501 --name=tf_serving_use -t tf-serving