############################################################
# Signal Sciences Nginx container
#
############################################################
FROM ubuntu:xenial

# File Author / Maintainer
MAINTAINER John Arroyo, john@arroyolabs.com


# Add repos and keys
RUN apt-get update
RUN apt-get install -y apt-transport-https wget gnupg
RUN wget -qO - https://apt.signalsciences.net/release/gpgkey | apt-key add -

# Add package for Signal Sciences ubuntu:xenial
RUN echo "deb https://apt.signalsciences.net/release/ubuntu/ xenial main" > /etc/apt/sources.list.d/sigsci-release.list

# Get Nginx 1.14.2
RUN echo "deb http://nginx.org/packages/ubuntu/ xenial nginx" > /etc/apt/sources.list.d/nginx-release.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list.d/nginx-release.list
RUN export key=ABF5BD827BD9BF62 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $key
RUN apt-get update
RUN apt-get -y install nginx

# Installing needed components
RUN apt-get -y install sigsci-agent
RUN apt-get install nginx-module-lua
RUN apt-get install sigsci-module-nginx

# Expose web ports
EXPOSE 443 80

# Nginx config for Lua and 
COPY nginx.conf /etc/nginx/nginx.conf

# Startup script for running sigsci-agent service
COPY start.sh /root/start.sh

# Execute permissions on the startup file
RUN chmod +x /root/start.sh

# Cleanup
RUN apt-get purge -y --auto-remove

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
