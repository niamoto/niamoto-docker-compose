#!/usr/bin/env bash

# Change owner of site media directory to ncbif
sudo chown -R ncbif /home/ncbif/ncbif-portal/site_media

# Wait for postgres server to be ready
sleep 3
echo "Wait for postgres database to be ready"
python wait_for_postgres.py

# Collect static files
echo "Collecting static files"
python ncbif-portal/manage.py collectstatic --noinput

# Make and apply migrations
echo "Making migrations"
python ncbif-portal/manage.py makemigrations
echo "Applying migrations"
python ncbif-portal/manage.py migrate

# Create default superuser if does not exist
echo "Creating default superuser if needed (ncbif_admin)"
python ncbif-portal/manage.py shell < init_superuser.py

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
