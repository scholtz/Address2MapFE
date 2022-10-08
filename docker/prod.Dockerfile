FROM nginxinc/nginx-unprivileged:latest
USER root
RUN apt update && apt dist-upgrade -y && apt install -y mc wget telnet dnsutils git curl iotop atop vim && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN mkdir /app
USER nginx
COPY Address2MapFE/docker/default.conf /etc/nginx/conf.d/default.conf
COPY gh-pages /app
USER root
RUN chown nginx:nginx /app -R
RUN chown nginx:nginx /etc/nginx/conf.d -R
RUN chmod 0600 /etc/nginx/conf.d -R
RUN chmod 0700 /etc/nginx/conf.d
USER nginx
