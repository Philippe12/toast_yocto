FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y --purge && \
    apt-get install -y cpio python3 gawk wget git-core diffstat unzip texinfo gcc-multilib \
        build-essential chrpath python vim locales tzdata
RUN locale-gen en_US.UTF-8

RUN dpkg-reconfigure --frontend noninteractive tzdata

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /root

RUN git clone -b morty https://git.yoctoproject.org/git/poky poky-morty --depth=1
#    cd poky-morty && \
#    git clone -b morty https://git.openembedded.org/meta-openembedded && \
#    git clone -b morty https://git.yoctoproject.org/git/meta-raspberrypi --depth=1 && \
#    git clone -b morty https://github.com/meta-qt5/meta-qt5.git --depth=1 && \
#    cd /root && \
#    mkdir rpi && \
#    cd rpi && \
#    git clone -b morty https://github.com/jumpnow/meta-rpi --depth=1

COPY build.sh /root/build.sh

# Install Toaster.
RUN apt install -y curl python3-pip

RUN pip3 install --user -r /root/poky-morty/bitbake/toaster-requirements.txt

EXPOSE 8000

CMD ["/bin/bash", "/root/build.sh"]
