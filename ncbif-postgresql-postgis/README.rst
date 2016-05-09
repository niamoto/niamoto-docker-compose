==============================
ncbif-postgresql-postgis image
==============================

This image contains a PostgreSQL/postGIS service.

It is based on the official postgres:9.4 image. Postgis extension had been
added, and the user "ncbif" with password "ncbif" are created after the
initialization of a container, with a ncbif database.
