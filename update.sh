#! /bin/bash
cd $NIAMOTO_DOCKER
sudo docker-compose down -v
sudo docker-compose up -d --build


