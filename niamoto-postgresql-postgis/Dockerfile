FROM postgres:10

MAINTAINER Tristan Mangeard <tmangeard@gmx.fr>

RUN localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8

# Install PostgreSQL / Postgis
RUN apt-get update \
      && apt-get install -y --no-install-recommends \
      postgresql-10-postgis-2.4 \
      postgis \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./init-user-db.sh /docker-entrypoint-initdb.d/
