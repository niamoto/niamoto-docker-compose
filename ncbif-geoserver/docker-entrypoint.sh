#!/usr/bin/env bash

set -e

if [ "${1:0:1}" = '-' ]; then
    set -- geoserver "$@"
fi

if [ "$1" = 'geoserver' ]; then
    if [ ! -s "logs/catalina.out" ]; then
        touch logs/catalina.out

        # Start tomcat service
        sh /usr/local/tomcat/bin/startup.sh

        echo "Initializing Tomcat for the first startup"

        # Wait until tomcat server is ready
        echo "Wait for tomcat server to be ready"

        LOG_TAIL=`tail -n 1 logs/catalina.out`
        TIMEOUT=180 # Tomcat startup timeout in seconds
        CURRENT=0

        until [[ "$LOG_TAIL" == *"Server startup in"* ]];
        do
            if (( "$CURRENT" >= "$TIMEOUT" )); then
                exit 1
            fi
            printf "."
            sleep 3
            LOG_TAIL=`tail -n 1 logs/catalina.out`
            CURRENT=$((CURRENT + 3))
        done

        echo "Tomcat is ready!"

        # Create ncbif user
        echo "Creating Geoserver's ncbif user"
        curl -X POST \
                 --data '{"userName": "ncbif", "password": "ncbif", "enabled": true}' \
                 -H "accept: application/json" -H "content-type: application/json" \
                 -u admin:geoserver localhost:8080/geoserver/geofence/rest/usergroup/users/
        echo "Geoserver's ncbif user created"
    else
        # Start tomcat service
        sh /usr/local/tomcat/bin/startup.sh
    fi
fi

tail -f logs/catalina.out
