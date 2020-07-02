#! /bin/bash
cd $NIAMOTO_DOCKER
docker-compose down -v
docker-compose up -d --build


