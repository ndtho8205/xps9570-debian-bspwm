FROM debian:buster-slim as debian_sudo
RUN rm -rf /etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian buster main contrib" > /etc/apt/sources.list && \
  echo "deb http://security.debian.org/debian-security buster/updates main contrib" >> /etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian buster-updates main contrib" >> /etc/apt/sources.list
RUN apt-get update && apt-get -y install sudo
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
COPY ./setup_init.sh /tmp/setup_init.sh
RUN ./tmp/setup_init.sh -f

FROM debian_sudo
WORKDIR /scripts/
COPY . /scripts/
