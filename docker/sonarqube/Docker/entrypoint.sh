#!/bin/bash
set -e

DEFAULT_CMD=('/opt/java/openjdk/bin/java' '-jar' 'lib/sonarqube.jar' '-Dsonar.log.console=true')

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- "${DEFAULT_CMD[@]}" "$@"
fi

exec "$@"
