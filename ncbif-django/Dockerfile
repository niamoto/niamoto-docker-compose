FROM python:3.5

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

# Update and install git
RUN apt-get update && apt-get install -y git

# Upgrade pip
RUN pip install --upgrade pip

# Set working dir
RUN mkdir -p /home/ncbif
WORKDIR /home/ncbif

# Install Gunicorn
RUN pip install gunicorn
COPY gunicorn_start.sh ./
RUN chmod +x ./gunicorn_start.sh

# Download and install django-ncbif-taxa
RUN git clone https://gitlab.com/ncbif/django-ncbif-taxa.git && \
    pip install -r django-ncbif-taxa/requirements.txt &&\
    pip install ./django-ncbif-taxa

# Download and install django-ncbif-occurrences
RUN git clone https://gitlab.com/ncbif/django-ncbif-occurrences.git && \
    pip install -r django-ncbif-occurrences/requirements.txt &&\
    pip install ./django-ncbif-occurrences

# Download and install django-ncbif-plantnote
RUN git clone https://gitlab.com/ncbif/django-ncbif-plantnote.git && \
    pip install -r django-ncbif-plantnote/requirements.txt &&\
    pip install ./django-ncbif-plantnote

# Download and install django-ncbif-geoserver-admin
RUN git clone https://gitlab.com/ncbif/django-ncbif-geoserver-admin.git && \
    pip install -r django-ncbif-geoserver-admin/requirements.txt &&\
    pip install ./django-ncbif-geoserver-admin

# Download and install ncbif-portal
RUN git clone https://gitlab.com/ncbif/ncbif-portal.git && \
    pip install -r ncbif-portal/requirements.txt

# Copy the ncbif django template setting file
ADD settings.py ncbif-portal/ncbif/

# Generate django's secret key
RUN python ncbif-portal/generate_secret_key.py --path ncbif-portal/ncbif/settings.py

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/docker-entrypoint.sh"]
