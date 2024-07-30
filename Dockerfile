# Use the TensorFlow Serving base image
FROM tensorflow/serving:latest

# Set environment variables
ENV MODEL_NAME=use-multilingual-large

# Create directories for models and configurations
RUN mkdir -p /models /models_config /batching_config

# Copy the model files and configuration files into the container
COPY ./models /models
COPY ./models_config /models_config
COPY ./batching_config /batching_config

# Expose the ports that TensorFlow Serving uses
EXPOSE 8501 8500

# Set the entrypoint for the container
ENTRYPOINT ["/usr/bin/tensorflow_model_server"]

# Define the default command to run TensorFlow Serving with the specified configurations
CMD ["--rest_api_port=8501", \
     "--model_name=${MODEL_NAME}", \
     "--model_base_path=/models", \
     "--model_config_file=/models_config/models.config", \
     "--batching_parameters_file=/batching_config/batching_parameters.txt", \
     "--monitoring_config_file=/models_config/monitoring.config", \
     "--model_config_file_poll_wait_seconds=60", \
     "--enable_batching=true", \
     "--tensorflow_session_parallelism=2"]
