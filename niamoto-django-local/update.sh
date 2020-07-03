#! /bin/bash
cd $NIAMOTO_COMPOSE
docker-compose down -v
docker-compose up -d --build


