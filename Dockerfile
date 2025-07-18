# Openwrt docker compilation environment Dockerfile.

FROM ubuntu:20.04

LABEL maintainer="Bad Boy <bxad397@gmail.com>"
LABEL description="Openwrt compilation environment"
LABEL version="2.0"

# Define build parameters
ARG ROOT_PASSWD=
ARG MY_USER=
ARG MY_USER_PASSWD=
ARG ALL_PROXY=
ARG http_proxy=
ARG https_proxy=

# Set environment variables
ENV FORCE_UNSAFE_CONFIGURE=1 \
    TZ=Asia/Shanghai \
    LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:zh \
    LC_ALL=zh_CN.UTF-8 \
    PATH="${PATH}:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

# Set time zone and replace apt source.
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
    # Update and install necessary packages, clean cache.
    apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    language-pack-zh-hans fonts-wqy-zenhei \
    sudo bash-completion less ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
    bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
    git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev \
    libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz \
    mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pip python3-pyelftools python3-setuptools \
    libpython3-dev qemu-utils rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip \
    wget xmlto xxd zlib1g-dev uuid-runtime upx git-core libz-dev lib32gcc-s1 zstd libgsl-dev bc u-boot-tools && \
    fc-cache -f -v && \
    # Clean apt cache and temporary files.
    apt-get clean && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# Configuration error warning color.
COPY color-compile/ /tmp/color-compile/
RUN make -C /tmp/color-compile && make -C /tmp/color-compile install && \
    rm -rf /tmp/color-compile

# Create User and Config.
RUN useradd -m -s /bin/bash ${MY_USER} && \
    echo "${MY_USER}:${MY_USER_PASSWD}" | chpasswd && \
    echo "${MY_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${MY_USER} && \
    chmod 0440 /etc/sudoers.d/${MY_USER}

# Configure user workspace.
COPY bashrc /home/${MY_USER}/.bashrc
RUN chown ${MY_USER}:${MY_USER} /home/${MY_USER}/.bashrc

# Set working directory and default user.
WORKDIR /home/${MY_USER}
USER ${MY_USER}
CMD ["bash"]

