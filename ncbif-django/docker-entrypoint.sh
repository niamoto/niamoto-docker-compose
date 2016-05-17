#!/usr/bin/env bash

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
python ncbif-portal/manage.py runserver 0.0.0.0:80
