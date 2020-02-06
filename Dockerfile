#FROM debian:jessie
#FROM ubuntu:18.04

# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-18.04

# Install xterm.
RUN add-pkg xterm

# Set the name of the application.
ENV APP_NAME="Xterm"


#FROM x11docker/deepin
#ARG DISPLAY

RUN apt-get update
COPY dockerrun.sh /usr/local/bin/dockerrun.sh

RUN apt -y install git qt5-default libusb-1.0-0-dev libhidapi-dev i2c-tools kmod build-essential libgl1-mesa-dev libseccomp2
RUN git clone https://gitlab.com/GaryPate/OpenRGB.git && cd OpenRGB && git submodule update --init --recursive
WORKDIR /OpenRGB
RUN qmake OpenRGB.pro && make
CMD ["bash", "dockerrun.sh"]

