#!/usr/bin/env bash

# Start flower monitoring

celery --workdir="/home/niamoto/niamoto-portal" flower -A niamoto worker \
       --addres="0.0.0.0" --port="5555" \
       --loglevel=info --broker="amqp://niamoto-rabbitmq:5672//" \
       --logfile="/home/niamoto/log/flower/%n%I.log" \
       --pidfile="/home/niamoto/run/flower/%n.pid"
