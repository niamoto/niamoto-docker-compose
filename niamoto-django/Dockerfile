FROM python:3.5

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

ARG NIAMOTO_TAXA_VERSION
ARG NIAMOTO_OCCURRENCES_VERSION
ARG NIAMOTO_PLANTNOTE_VERSION
ARG NIAMOTO_MASSIFS_VERSION
ARG NIAMOTO_GEOSERVER_ADMIN_VERSION
ARG NIAMOTO_PORTAL_VERSION

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

# Download and install django-niamoto-taxa
RUN git clone https://github.com/niamoto/django-niamoto-taxa.git && \
    cd django-niamoto-taxa && \
    git checkout $NIAMOTO_TAXA_VERSION && \
    cd .. && \
    sudo pip install -r django-niamoto-taxa/requirements.txt &&\
    sudo pip install ./django-niamoto-taxa

# Download and install django-niamoto-occurrences
RUN git clone https://github.com/niamoto/django-niamoto-occurrences.git && \
    cd django-niamoto-occurrences && \
    git checkout $NIAMOTO_OCCURRENCES_VERSION && \
    cd .. && \
    sudo pip install -r django-niamoto-occurrences/requirements.txt &&\
    sudo pip install ./django-niamoto-occurrences

# Download and install django-niamoto-plantnote
RUN git clone https://github.com/niamoto/django-niamoto-plantnote.git && \
    cd django-niamoto-plantnote && \
    git checkout $NIAMOTO_PLANTNOTE_VERSION && \
    cd .. && \
    sudo pip install -r django-niamoto-plantnote/requirements.txt &&\
    sudo pip install ./django-niamoto-plantnote

# Download and install django-niamoto-massifs
RUN git clone https://github.com/niamoto/django-niamoto-massifs.git && \
    cd django-niamoto-massifs && \
    git checkout $NIAMOTO_MASSIFS_VERSION && \
    cd .. && \
    sudo pip install -r django-niamoto-massifs/requirements.txt &&\
    sudo pip install ./django-niamoto-massifs

# Download and install django-niamoto-geoserver-admin
RUN git clone https://github.com/niamoto/django-niamoto-geoserver-admin.git && \
    cd django-niamoto-geoserver-admin && \
    git checkout $NIAMOTO_GEOSERVER_ADMIN_VERSION && \
    cd .. && \
    sudo pip install -r django-niamoto-geoserver-admin/requirements.txt &&\
    sudo pip install ./django-niamoto-geoserver-admin

# Download and install niamoto-portal
RUN git clone https://github.com/niamoto/niamoto-portal.git && \
    cd niamoto-portal && \
    git checkout $NIAMOTO_PORTAL_VERSION && \
    cd .. && \
    sudo pip install -r niamoto-portal/requirements.txt

# Add the niamoto django template setting file
ADD settings.py niamoto-portal/niamoto/

# Add init_superuser script
ADD init_superuser.py /home/niamoto

# Add wait_for_postgres script
ADD wait_for_postgres.py /home/niamoto

# Generate django's secret key
RUN python niamoto-portal/generate_secret_key.py --path niamoto-portal/niamoto/settings.py

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
