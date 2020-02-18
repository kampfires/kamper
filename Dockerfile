#
# Kamper - Kubernetes App Mgmt Platform Engineering Runtime
#
# #

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install -y pandoc && \
  rm -rf /var/lib/apt/lists/*

ENV OVFTOOL_VERSION 4.3.0-14746126

# Install ovftool
RUN \
  wget -q https://pksninja-bucket.s3.us-east-2.amazonaws.com/vmware-ovftool-4.3.0-14746126-lin.x86_64.bundle && \
  wget -q https://pksninja-bucket.s3.us-east-2.amazonaws.com/vmware-ovftool-4.3.0-14746126-lin.x86_64.bundle.sha256 && \
  sh vmware-ovftool-4.3.0-14746126-lin.x86_64.bundle -p /usr/local --eulas-agreed --required && \
  rm -f vmware-ovftool-4.3.0-14746126-lin.x86_64.bundle*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
