FROM registry.h1.scholtz.sk/nginx18-php8:latest
USER root
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt dist-upgrade -y && apt install -y mc wget telnet dnsutils git curl iotop atop vim && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN mkdir /app
WORKDIR /app

COPY gh-pages /app
COPY Address2MapFE/docker/cmd.sh /cmd.sh
RUN chmod 0700 /cmd.sh
COPY Address2MapFE/docker/default.conf /etc/nginx/sites-available/default.conf
