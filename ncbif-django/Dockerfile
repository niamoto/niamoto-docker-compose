FROM python:3.5

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

# Update and install git
RUN apt-get update && apt-get install -y git && apt-get install sudo && apt-get install daemon

# Upgrade pip
RUN pip install --upgrade pip

# Create ncbif user, set as current user and set working dir
RUN useradd -m ncbif
ADD sudoers /etc/sudoers
USER ncbif
RUN mkdir -p /home/ncbif
WORKDIR /home/ncbif

# Install Gunicorn
RUN sudo pip install gunicorn
ADD gunicorn_start.sh ./
RUN sudo chmod +x ./gunicorn_start.sh

# Download and install django-ncbif-taxa
RUN git clone https://gitlab.com/ncbif/django-ncbif-taxa.git && \
    sudo pip install -r django-ncbif-taxa/requirements.txt &&\
    sudo pip install ./django-ncbif-taxa

# Download and install django-ncbif-occurrences
RUN git clone https://gitlab.com/ncbif/django-ncbif-occurrences.git && \
    sudo pip install -r django-ncbif-occurrences/requirements.txt &&\
    sudo pip install ./django-ncbif-occurrences

# Download and install django-ncbif-plantnote
RUN git clone https://gitlab.com/ncbif/django-ncbif-plantnote.git && \
    sudo pip install -r django-ncbif-plantnote/requirements.txt &&\
    sudo pip install ./django-ncbif-plantnote

# Download and install django-ncbif-geoserver-admin
RUN git clone https://gitlab.com/ncbif/django-ncbif-geoserver-admin.git && \
    sudo pip install -r django-ncbif-geoserver-admin/requirements.txt &&\
    sudo pip install ./django-ncbif-geoserver-admin

# Download and install ncbif-portal
RUN git clone https://gitlab.com/ncbif/ncbif-portal.git && \
    sudo pip install -r ncbif-portal/requirements.txt

# Add the ncbif django template setting file
ADD settings.py ncbif-portal/ncbif/

# Add init_superuser script
ADD init_superuser.py /home/ncbif

# Add wait_for_postgres script
ADD wait_for_postgres.py /home/ncbif

# Generate django's secret key
RUN python ncbif-portal/generate_secret_key.py --path ncbif-portal/ncbif/settings.py

# Prepare celery daemon
RUN sudo wget -P /etc/init.d https://raw.githubusercontent.com/celery/celery/3.1/extra/generic-init.d/celeryd
ADD celeryd /etc/default/celeryd

# Prepare flower monitor
ADD flower_startup.sh /home/ncbif/flower_startup.sh
ADD flower /etc/init.d/flower
RUN sudo chmod 0755 /home/ncbif/flower_startup.sh
RUN sudo chmod 0755 /etc/init.d/flower

ADD docker-entrypoint.sh /
RUN sudo chmod +x /docker-entrypoint.sh

EXPOSE 8000
EXPOSE 5555

ENTRYPOINT ["/docker-entrypoint.sh"]
