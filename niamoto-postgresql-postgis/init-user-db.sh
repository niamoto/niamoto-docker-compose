#!/usr/bin/env bash

set -e

# Create niamoto user and niamoto database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE USER niamoto WITH PASSWORD 'niamoto';"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE DATABASE niamoto;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "GRANT ALL PRIVILEGES ON DATABASE niamoto TO niamoto;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d niamoto -c "CREATE EXTENSION postgis;"

# Create niamoto_readonly user, for readonly access to niamoto database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE USER niamoto_readonly WITH PASSWORD 'niamoto_readonly';"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d niamoto -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO niamoto_readonly;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d niamoto -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO niamoto_readonly;"
