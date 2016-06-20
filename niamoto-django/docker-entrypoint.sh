#!/usr/bin/env bash

# Change owner of site media directory to niamoto
sudo chown -R niamoto /home/niamoto/niamoto-portal/site_media

# Wait for postgres server to be ready
sleep 3
echo "Wait for postgres database to be ready"
python wait_for_postgres.py

# Make and apply migrations
echo "Making migrations"
sudo python niamoto-portal/manage.py makemigrations
echo "Applying migrations"
sudo python niamoto-portal/manage.py migrate

# Loading fixture data
echo "Loading fixtures"
python niamoto-portal/manage.py loaddata niamoto-portal/fixtures/sites.json

# Create default superuser if does not exist
echo "Creating default superuser if needed (niamoto_admin)"
python niamoto-portal/manage.py shell < init_superuser.py

# Collect static files
echo "Collecting static files"
python niamoto-portal/manage.py collectstatic --noinput

# Start celery worker
echo "Starting celery worker"
sudo sh /etc/init.d/celeryd start
echo "Celery worker started"

# Start flower monitoring
echo "Starting flower monitor"
sudo sh /etc/init.d/flower start
echo "flower monitor started"

# Start server
echo "Starting server"

if [ "$1" = "debug" ]; then
    bash
else
    ./gunicorn_start.sh
fi
