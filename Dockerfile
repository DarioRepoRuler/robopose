# NVIDIA BASE IMAGE for the project


# Use an official Ubuntu as a parent image
FROM ubuntu:18.04

# Set environment variables for NVIDIA runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Set noninteractive mode during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Install wget and other dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    gnupg \
    gnupg1 \
    gnupg2 && \
    rm -rf /var/lib/apt/lists/*

# Download and install CUDA Toolkit
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin \
    && mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600 \
    && wget https://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1804-10-1-local-10.1.243-418.87.00_1.0-1_amd64.deb 
RUN dpkg -i cuda-repo-ubuntu1804-10-1-local-10.1.243-418.87.00_1.0-1_amd64.deb \
    && apt-key add /var/cuda-repo-10-1-local-10.1.243-418.87.00/7fa2af80.pub \
    && apt-get update \
    && apt-get -y install cuda

# Cleanup
RUN rm cuda-repo-ubuntu1804-10-1-local-10.1.243-418.87.00_1.0-1_amd64.deb

# Install Conda
RUN apt-get install -y --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git && \
    rm -rf /var/lib/apt/lists/* && \
    wget --quiet https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O /tmp/anaconda.sh && \
    /bin/bash /tmp/anaconda.sh -b -p /opt/conda && \
    rm /tmp/anaconda.sh && \
    /opt/conda/bin/conda clean -tipsy


# Set environment variables
ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:${LD_LIBRARY_PATH}
ENV PATH="/opt/conda/bin:${PATH}"

# Create a shared folder at /home/Documents/AUT_Projekt/robopose
#VOLUME ./robopose /app/

# Set the working directory
WORKDIR /app

# Copy all files from the host into the container
# COPY ./local_data  /app/local_data
# COPY ./deps /app/deps
# COPY ./environment.yaml /app/
# COPY ./notebooks /app/notebooks/
# COPY 
COPY . /app/

# Create a Conda environment and activate it
RUN /opt/conda/bin/conda env create -n robopose -f /app/environment.yaml \
    && echo "conda activate robopose" >> /root/.bashrc

# Install Python dependencies
RUN echo "source activate robopose" > /root/.bashrc

# Command to run when the container starts
CMD ["bash"]