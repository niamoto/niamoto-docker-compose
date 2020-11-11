#! /bin/bash
cd $NIAMOTO_COMPOSE
sudo docker-compose down -v
sudo docker rmi niamoto-django-local_niamoto-django niamoto-django-local_niamoto-nginx
sudo docker-compose up -d --build

