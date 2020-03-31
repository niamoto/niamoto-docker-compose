FROM python:3.8

MAINTAINER Tristan Mangeard <tmangeard@gmx.fr>

# Update sources.list with sid (required for mod_spatialite)
RUN echo 'deb http://httpredir.debian.org/debian sid main' >> /etc/apt/sources.list

# Update and install git
RUN apt-get update && apt-get install -y git && apt-get install sudo && apt-get install daemon

RUN git config --global user.email "tmangeard@gmx.fr" && \
    git config --global user.name "CheckFly"

# Add mod_spatialite shared library
RUN apt-get install -y libsqlite3-mod-spatialite --fix-missing

# Install geospatial dependencies
RUN sudo apt-get install -y binutils libproj-dev gdal-bin

# Install postgresql-client for dbbackups
RUN sudo sed -e '/deb http\:\/\/httpredir.debian.org\/debian sid main/ s/^#*/#/' -i /etc/apt/sources.list
RUN apt-get update
RUN sudo apt-get install -y postgresql-client --fix-missing

# Upgrade pip
RUN pip install --upgrade pip

# Create niamoto user, set as current user and set working dir
RUN useradd -m niamoto
ADD sudoers /etc/sudoers
USER niamoto
RUN mkdir -p /home/niamoto
WORKDIR /home/niamoto

# Install Gunicorn
RUN sudo pip install gunicorn
ADD gunicorn_start.sh ./
RUN sudo chmod +x ./gunicorn_start.sh

# Download niamoto-portal
RUN git clone https://github.com/niamoto/niamoto-portal.git

# Add the niamoto django template setting file
ADD settings.py niamoto-portal/niamoto/

# Add init_superuser script
ADD init_superuser.py /home/niamoto

# Add wait_for_postgres script
ADD wait_for_postgres.py /home/niamoto

ADD docker-entrypoint.sh /
RUN sudo chmod +x /docker-entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/docker-entrypoint.sh"]
