FROM riscv64/ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -qq && apt install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    git \
    curl \
    wget \
    vim \
    ruby \
    xvfb \
    x11vnc \
    xfce4 \
    xfce4-goodies \
    at-spi2-core \
    dbus-x11 \
    net-tools \
    x11-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN echo "export PATH=$PATH:/root/.cargo/bin" >> ~/.bashrc

# VNC server
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd
RUN echo "xfce4-session" > ~/.xinitrc
RUN chmod +x ~/.xinitrc

WORKDIR /root

COPY bashrc /root/.bashrc
COPY vimrc /root/.vimrc
COPY vim /root/.vim

EXPOSE 5900

CMD ["x11vnc", "-repeat", "-forever", "-usepw", "-create"]
