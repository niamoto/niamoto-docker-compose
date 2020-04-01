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

# Wait for postgres server to be ready
sleep 3
echo "Wait for postgres database to be ready"
python wait_for_postgres.py

# Make and apply migrations
echo "Making migrations"
python niamoto-portal/manage.py makemigrations
echo "Applying migrations"
python niamoto-portal/manage.py migrate
echo "Insert data"
python niamoto-portal/manage.py loaddata niamoto-portal/data.json

# Loading fixture data
# echo "Loading fixtures"
# python niamoto-portal/manage.py loaddata niamoto-portal/fixtures/sites.json

# Create default superuser if does not exist
echo "Creating default superuser if needed (niamoto_admin)"
python niamoto-portal/manage.py shell < init_superuser.py

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
