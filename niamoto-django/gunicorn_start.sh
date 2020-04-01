#!/bin/bash

NAME="niamoto_portal"                      # Name of the application (*)
DJANGODIR=/home/niamoto/niamoto-portal       # Django project directory (*)
USER=`whoami`                            # the user to run as (*)
GROUP=`whoami`                           # the group to run as (*)
NUM_WORKERS=1                            # how many worker processes should Gunicorn spawn (*)
DJANGO_SETTINGS_MODULE=niamoto_portal.settings.production    # which settings file should Django use (*)
DJANGO_WSGI_MODULE=niamoto_portal.wsgi            # WSGI module name (*)

mkdir /home/niamoto/log

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
# source /var/www/test/venv/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH
export ENV=PRODUCTION   

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user $USER \
  --bind=0.0.0.0:8000 \
  --access-logfile /home/niamoto/log/accesslog.log \
  --pid /home/niamoto/gunicorn.pid
