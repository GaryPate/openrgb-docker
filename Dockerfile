#FROM debian:jessie
#FROM ubuntu:18.04
FROM phusion/baseimage

#ARG SSH_SECRET


#ENV INSTALL_PATH openrgb_docker
#WORKDIR $INSTALL_PATH
#WORKDIR /root
RUN apt-get update

#RUN apt-get -y install sudo

#RUN adduser --disabled-password --gecos '' docker
#RUN adduser docker sudo
#RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#USER docker

# COPY dockerrun.sh /usr/local/bin/dockerrun.sh
# RUN sudo mkdir /root/.ssh/
# RUN sudo chown -R docker /root/
# RUN sudo chmod -R 777 /root/
# RUN sudo apt -y install git qt5-default libusb-1.0-0-dev libhidapi-dev i2c-tools kmod build-essential libgl1-mesa-dev libseccomp2 cmake
# RUN sudo echo "${SSH_SECRET}" > /root/.ssh/id_docker
# RUN sudo git clone https://gitlab.com/GaryPate/OpenRGB.git && cd OpenRGB && sudo git submodule update --init --recursive
# WORKDIR /OpenRGB
# RUN sudo qmake OpenRGB.pro && sudo make
# CMD ["bash", "dockerrun.sh"]

COPY dockerrun.sh /usr/local/bin/dockerrun.sh
RUN mkdir /root/.ssh/
#RUN chown -R docker /root/
#RUN sudo chmod -R 777 /root/
RUN apt -y install git qt5-default libusb-1.0-0-dev libhidapi-dev i2c-tools kmod build-essential libgl1-mesa-dev libseccomp2
#RUN sudo echo "${SSH_SECRET}" > /root/.ssh/id_docker
RUN git clone https://gitlab.com/GaryPate/OpenRGB.git && cd OpenRGB && git submodule update --init --recursive
WORKDIR /OpenRGB
RUN qmake OpenRGB.pro && make
CMD ["bash", "dockerrun.sh"]

