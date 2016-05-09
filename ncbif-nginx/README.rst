===========
ncbif-nginx
===========

This image contains a nginx service configured for working with a Gunicorn
server, serving ncbif.

It is based on debian:jessie official Docker image.

When a container is started, the 80 port is exposed, and the nginx service is
configured to listen a gunicorn socket (located at "/tmp/gunicorn.sock"), and
to find static and media files upon "/home/ncbif/ncbif_portal/site_media/[static OR media]/".
