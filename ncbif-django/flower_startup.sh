#!/usr/bin/env bash

# Start flower monitoring

celery --workdir="/home/ncbif/ncbif-portal" flower -A ncbif worker \
       --addres="0.0.0.0" --port="5555" \
       --loglevel=info --broker="amqp://ncbif-rabbitmq:5672//" \
       --logfile="/home/ncbif/log/flower/%n%I.log" \
       --pidfile="/home/ncbif/run/flower/%n.pid"
