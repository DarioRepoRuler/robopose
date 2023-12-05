# PROJECT DOCKER CONTAINER

# Use an official Ubuntu as a parent image
FROM cuda_base_v2:latest

# Set environment variables for NVIDIA runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Create a temporary directory and copy everything
COPY . /app/robopose

# Install Python dependencies
RUN echo "source activate robopose" > /root/.bashrc
RUN echo "python setup.py install" >> /root/.bashrc

# Update system
#RUN echo "source activate robopose" > /root/.bashrc
RUN echo "runjob-config job-runner-config.yaml" >> /root/.bashrc
RUN echo "export CUDA_VISIBLE_DEVICES=0" >> /root/.bashrc
RUN echo "python setup.py install" >> /root/.bashrc
# Add ROS Repo
RUN echo ""deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list" >> /root/.bashrc
RUN echo "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654" >> /root/.bashrc
RUN echo "apt-get update" >> /root/.bashrc
RUN echo "sudo apt-get install -y liburdfdom-dev" >> /root/.bashrc
# Set config file
RUN echo "runjob-config job-runner-config.yaml" >> /root/.bashrc

# Command to run when the container starts
CMD ["bash"]
