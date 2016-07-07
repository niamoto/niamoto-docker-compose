FROM python:3.5

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

# Update and install git
RUN apt-get update && apt-get install -y git && apt-get install sudo && apt-get install daemon

# Install geospatial dependencies
RUN sudo apt-get install -y binutils libproj-dev gdal-bin

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

# Prepare celery daemon
RUN sudo wget -P /etc/init.d https://raw.githubusercontent.com/celery/celery/3.1/extra/generic-init.d/celeryd
ADD celeryd /etc/default/celeryd

# Prepare flower monitor
ADD flower_startup.sh /home/niamoto/flower_startup.sh
ADD flower /etc/init.d/flower
RUN sudo chmod 0755 /home/niamoto/flower_startup.sh
RUN sudo chmod 0755 /etc/init.d/flower

ADD docker-entrypoint.sh /
RUN sudo chmod +x /docker-entrypoint.sh

EXPOSE 8000
EXPOSE 5555

ENTRYPOINT ["/docker-entrypoint.sh"]
