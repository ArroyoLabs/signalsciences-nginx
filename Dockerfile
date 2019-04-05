############################################################
# Signal Sciences Nginx container
#
############################################################
FROM nginx:1.14

# File Author / Maintainer
MAINTAINER John Arroyo, john@arroyolabs.com

# Add repos and keys
RUN apt-get update
RUN apt-get install -y apt-transport-https wget gnupg
RUN wget -qO - https://apt.signalsciences.net/release/gpgkey | apt-key add -

# Depending on Ubuntu version, need to add the correct repo, 16.04 "xenial"
RUN echo "deb https://apt.signalsciences.net/release/ubuntu/ xenial main" > /etc/apt/sources.list.d/sigsci-release.list

RUN apt-get update

# Installing needed components
RUN apt-get -y install sigsci-agent
RUN apt-get install nginx-module-lua
RUN apt-get install sigsci-module-nginx

#Exposing port 443
EXPOSE 443

COPY nginx.conf /etc/nginx/nginx.conf

#Startup script for running sigsci-agent service
COPY start.sh /root/start.sh

#Execute permissions on the startup file
RUN chmod +x /root/start.sh
