====================
ncbif-docker-compose
====================

Project containing Docker images and Docker compose file to allow an easy deployment of ncbif with Docker.

Below a short description of each image, with specific information when necessary.


ncbif-nginx image
-----------------

This image contains a nginx service configured for working with a Gunicorn server, serving ncbif.


ncbif-postgresql-postgis image
------------------------------

This image contains a PostgreSQL/postGIS service.


ncbif-geoserver image
---------------------

This image contains a Geoserver service.


ncbif-rabbitmq image
--------------------

This image contains a RabbitMQ service.


ncbif-django image
------------------

This image contains the ncbif Django application, served by Gunicorn, a celery service and a flower service for monitoring it.
