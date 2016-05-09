FROM postgres:9.4

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

RUN localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8

# Install PostgreSQL / Postgis
RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-9.4-postgis-2.2=2.2.2+dfsg-1.pgdg80+1 \
           postgis=2.2.2+dfsg-1.pgdg80+1 \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./init-user-db.sh /docker-entrypoint-initdb.d/
