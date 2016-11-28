FROM debian:jessie

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove default Nginx conf file
RUN rm -v /etc/nginx/nginx.conf

# Copy the niamoto Nginx conf files
ADD nginx.conf /etc/nginx/
ADD ssl-niamoto.ird.nc.conf /etc/nginx/snippets
ADD ssl-params.conf /etc/nginx/snippets

# Remove nginx default welcome page
RUN rm /usr/share/nginx/html/index.html

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80 443

# Start nginx service
CMD nginx
