====================
niamoto-docker-compose
====================

Project containing Docker images and Docker compose file to allow an easy deployment of niamoto with Docker.

Below a short description of each image, with specific information when necessary.


niamoto-nginx image
-----------------

This image contains a nginx service configured for working with a Gunicorn server, serving niamoto.


niamoto-postgresql-postgis image
------------------------------

This image contains a PostgreSQL/postGIS service.


niamoto-geoserver image
---------------------

This image contains a Geoserver service.


niamoto-rabbitmq image
--------------------

This image contains a RabbitMQ service.


niamoto-django image
------------------

This image contains the niamoto Django application, served by Gunicorn, a celery service and a flower service for monitoring it.
