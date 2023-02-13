# Download base image ubuntu 22.04
FROM ubuntu:22.04

# LABEL about the custom image
LABEL maintainer="jeff.butte@linkedsolutions.net"
LABEL version="1.0"
LABEL description="This is a custom Docker Image for Unifi-Cam-Proxy for Pakage Cameras."

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update

WORKDIR /app

RUN apt install -y gcc libc-dev linux-headers libusb-dev
RUN apt install -y ffmpeg netcat-openbsd git

RUN rm -rf /var/lib/apt/lists/*
RUN apt clean

COPY . .
RUN pip install .

COPY ./docker/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["unifi-cam-proxy"]
