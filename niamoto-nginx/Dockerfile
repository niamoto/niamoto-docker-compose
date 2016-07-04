FROM debian:jessie

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove default Nginx conf file
RUN rm -v /etc/nginx/nginx.conf

# Copy the niamoto Nginx conf file
ADD nginx.conf /etc/nginx/

# Remove nginx default welcome page
RUN rm /usr/share/nginx/html/index.html

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80

# Start nginx service
CMD nginx
