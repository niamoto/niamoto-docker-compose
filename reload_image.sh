#! /bin/bash
cd $NIAMOTO_COMPOSE
sudo docker-compose down -v
sudo docker rmi niamoto-docker-compose_niamoto-nginx niamoto-docker-compose_niamoto-django niamoto-docker-compose_niamoto-postgres
sudo docker-compose up -d --build

