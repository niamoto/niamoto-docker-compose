#!/usr/bin/env bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE USER ncbif WITH PASSWORD 'ncbif';"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "CREATE DATABASE ncbif;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "GRANT ALL PRIVILEGES ON DATABASE ncbif TO ncbif;"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d ncbif -c "CREATE EXTENSION postgis;"
