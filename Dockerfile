FROM ubuntu:18.04

EXPOSE 8000

ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y --purge && \
    apt-get install -y cpio python3 gawk wget git-core diffstat unzip texinfo gcc-multilib \
        build-essential chrpath python vim locales tzdata

RUN apt install -y curl python3-pip

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN dpkg-reconfigure --frontend noninteractive tzdata

WORKDIR /root

RUN git clone -b zeus https://git.yoctoproject.org/git/poky poky --depth=1

# Install Toaster.

RUN pip3 install --user -r /root/poky/bitbake/toaster-requirements.txt

COPY build.sh /root/build.sh

CMD ["/bin/bash", "/root/build.sh"]
