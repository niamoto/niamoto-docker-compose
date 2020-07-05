#! /bin/bash
cd $NIAMOTO_COMPOSE
sudo docker-compose down -v
sudo docker-compose up -d --build


