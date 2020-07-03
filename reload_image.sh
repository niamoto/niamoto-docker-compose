#! /bin/bash
cd $NIAMOTO_COMPOSE
docker-compose down -v
docker rmi niamoto-docker-compose_niamoto-nginx niamoto-docker-compose_niamoto-django niamoto-docker-compose_niamoto-postgres
docker-compose up -d --build

