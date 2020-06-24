#!/usr/bin/env bash

# Pull last version of niamoto-portal
cd niamoto-portal && \
git pull && \
cd .. && \
sudo pip install -r niamoto-portal/requirements.txt

# Generate secret key
# python niamoto-portal/generate_secret_key.py --path niamoto-portal/niamoto_portal/settings.py

# Change owner of site media and data directory to niamoto
sudo chown -R niamoto /home/niamoto/niamoto-portal/niamoto_portal/staticfiles
# sudo chown -R niamoto /home/niamoto/niamoto-portal/data

# Collect static files
echo "Collecting static files"
python niamoto-portal/manage.py collectstatic --noinput

# Start server
echo "Starting server"

if [ "$1" = "debug" ]; then
    bash
else
    ./gunicorn_start.sh
fi
