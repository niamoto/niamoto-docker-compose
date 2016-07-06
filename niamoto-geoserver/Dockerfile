FROM kartoza/geoserver

MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>

RUN mkdir -p /tmp/resources/plugins/

RUN wget -O /tmp/resources/plugins/geoserver-2.8-SNAPSHOT-geofence-server-plugin.zip http://ares.boundlessgeo.com/geoserver/2.8.x/community-latest/geoserver-2.8-SNAPSHOT-geofence-server-plugin.zip

# Taken from kartoza/geoserver Dockerfile
# Install any plugin zip files in resources/plugins
RUN if ls /tmp/resources/plugins/*.zip > /dev/null 2>&1; then \
      for p in /tmp/resources/plugins/*.zip; do \
        unzip $p -d /tmp/gs_plugin \
        && mv /tmp/gs_plugin/*.jar $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/ \
        && rm -rf /tmp/gs_plugin; \
      done; \
    fi

RUN rm -rf /tmp/resources

# Remove tomcat homepage
RUN rm $CATALINA_HOME/webapps/ROOT/index.jsp

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

RUN mkdir -p /opt/geoserver/data_dir/logs
RUN touch /opt/geoserver/data_dir/logs/geoserver.log

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["geoserver"]
