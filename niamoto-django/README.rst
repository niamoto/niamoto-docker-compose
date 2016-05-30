============
niamoto-django
============

This image contains the niamoto Django application.

It served by Gunicorn, which writes to a unix socket supposed to be listened
by a reverse proxy such as nginx.

It contains a celery service for asynchronous task queue, and a flower service
for monitoring it.

It is based on the python:3.5 official Docker image.
