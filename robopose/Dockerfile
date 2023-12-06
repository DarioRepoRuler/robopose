# PROJECT DOCKER CONTAINER

# Use an official Ubuntu as a parent image
FROM cuda_base_v3:latest

# Set environment variables for NVIDIA runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Create a temporary directory and copy everything
COPY . /app/robopose

# Install Python dependencies
RUN echo "source activate robopose" > /root/.bashrc
RUN echo "python setup.py install" >> /root/.bashrc

# # Install Git and SSH client
# RUN apt-get update && \
#     apt-get install -y git openssh-client

# # Set Git configurations
# RUN git config --global user.name "DarioRepoRuler" && \
#     git config --global user.email "e11806417@student.tuwien.ac.at"

# # Create a directory to store the SSH keys
# RUN mkdir -p /root/.ssh

# # Copy SSH key to the container (replace id_rsa with your actual key name)
# COPY id_rsa /root/.ssh/id_rsa
# COPY id_rsa.pub /root/.ssh/id_rsa.pub

# # Set permissions on the SSH keys
# RUN chmod 600 /root/.ssh/id_rsa && \
#     chmod 644 /root/.ssh/id_rsa.pub

# # Add GitHub host key to known hosts
# RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Update system
#RUN echo "source activate robopose" > /root/.bashrc
RUN echo "runjob-config job-runner-config.yaml" >> /root/.bashrc
RUN echo "export CUDA_VISIBLE_DEVICES=0" >> /root/.bashrc
# Add ROS Repo
RUN echo ""deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list" >> /root/.bashrc
RUN echo "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654" >> /root/.bashrc
RUN echo "apt-get update" >> /root/.bashrc
RUN echo "sudo apt-get install -y liburdfdom-dev" >> /root/.bashrc
RUN mkdir /app/jobs

RUN rm -rf /app/robopose

# Command to run when the container starts
CMD ["bash"]
