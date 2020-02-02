FROM debian:buster-slim

ARG SSH_SECRET


ENV INSTALL_PATH openrgb_docker
ENV HOME=/root
WORKDIR $INSTALL_PATH
RUN apt-get update

RUN apt-get -y install sudo

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker

COPY dockerrun.sh /usr/local/bin/dockerrun.sh
RUN sudo mkdir /root/.ssh/
RUN sudo chown -R docker /root/
RUN sudo chmod -R 777 /root/
RUN sudo apt -y install git qt5-default libusb-1.0-0-dev libhidapi-dev i2c-tools kmod
RUN sudo apt-get -y install build-essential
RUN sudo echo "${SSH_SECRET}" > /root/.ssh/id_docker
RUN sudo git clone https://gitlab.com/GaryPate/OpenRGB.git && cd OpenRGB && sudo git submodule update --init --recursive
WORKDIR OpenRGB/
RUN sudo qmake OpenRGB.pro
RUN sudo make
WORKDIR $INSTALL_PATH
CMD ["bash", "dockerrun.sh"]

