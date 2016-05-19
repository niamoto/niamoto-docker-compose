#!/usr/bin/env bash

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

# Start server
echo "Starting server"
#python ncbif-portal/manage.py runserver 0.0.0.0:80
./gunicorn_start.sh
