FROM python:3.8.2

MAINTAINER Tristan Mangeard <tmangeard@gmx.fr>

# Update sources.list with sid (required for mod_spatialite)
# RUN echo 'deb http://httpredir.debian.org/debian sid main' >> /etc/apt/sources.list

# Update and install git
RUN apt-get update && apt-get install -y git && apt-get install sudo && apt-get install daemon

RUN git config --global user.email "tmangeard@gmx.fr" && \
    git config --global user.name "CheckFly"

# Add mod_spatialite shared library
RUN apt-get install -y libsqlite3-mod-spatialite --fix-missing

# Install geospatial dependencies
RUN sudo apt-get install -y binutils libproj-dev gdal-bin

# Install postgresql-client for dbbackups
# RUN sudo sed -e '/deb http\:\/\/httpredir.debian.org\/debian sid main/ s/^#*/#/' -i /etc/apt/sources.list
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

# Install generate_data
ADD generate_data.sh ./

# Install Gunicorn
RUN sudo pip install gunicorn
ADD gunicorn_start.sh ./
RUN sudo chmod +x ./gunicorn_start.sh

# Download niamoto-portal
RUN git clone https://github.com/CheckFly/niamoto-portal.git

# Pip install
RUN sudo pip install -r ./niamoto-portal/requirements.txt

# Add the niamoto django template setting file
# ADD settings.py niamoto-portal/niamoto/

ENV ENV=PRODUCTION
ENV DJANGO_SETTINGS_MODULE=niamoto_portal.settings.local

ADD docker-entrypoint.sh /
RUN sudo chmod +x /docker-entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/docker-entrypoint.sh"]
