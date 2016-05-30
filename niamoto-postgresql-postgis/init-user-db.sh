#!/usr/bin/env bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE USER niamoto WITH PASSWORD 'niamoto';"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE DATABASE niamoto;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "GRANT ALL PRIVILEGES ON DATABASE niamoto TO niamoto;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d niamoto -c "CREATE EXTENSION postgis;"
