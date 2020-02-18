#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

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
  
# Set ENV for ovf Version
ENV OVFTOOL_VERSION 4.3.0-14746126

# Install ovftool
RUN OVFTOOL_INSTALLER=vmware-ovftool-${OVFTOOL_VERSION}-lin.x86_64.bundle \
 && wget -q https://pksninja-bucket.s3.us-east-2.amazonaws.com/${OVFTOOL_INSTALLER} \
 && wget -q https://storage.googleapis.com/mortarchive/pub/ovftool/${OVFTOOL_INSTALLER}.sha256 \
 && sha256sum -c ${OVFTOOL_INSTALLER}.sha256 \
 && sh ${OVFTOOL_INSTALLER} -p /usr/local --eulas-agreed --required \
 && rm -f ${OVFTOOL_INSTALLER}*


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
