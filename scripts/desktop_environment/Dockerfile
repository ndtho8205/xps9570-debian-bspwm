FROM debian:buster-slim as debian_sudo

RUN echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y checkinstall build-essential git

COPY ./*.sh /app/
WORKDIR /app
