# Use the official CUDA image as the base image
FROM nvidia/cuda:11.4.2-devel-ubuntu20.04

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any necessary dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Build the application
RUN mkdir build && \
    cd build && \
    cmake .. && \
    make

# Set the default command to run when the container starts
CMD ["./app"]
