#!/bin/bash
set -e
set -x

# mysql db
DB_TYPE=${DB_TYPE:-}
DB_HOST=${DB_HOST:-}
DB_PORT=${DB_PORT:-}
DB_NAME=${DB_NAME:-}
DB_USER=${DB_USER:-}
DB_PASS=${DB_PASS:-}

if [ -z "${DB_HOST}" ]; then
  echo "WARNING: "
  echo "  No mysql connection available."
  echo "  Will work with default H2 in-memory database."
  unset DB_TYPE
fi

# use default port number if it is still not set
case "${DB_TYPE}" in
  mysql)
    DB_PORT=${DB_PORT:-3306}
    sed 's/{{DB_PORT}}/'"${DB_PORT}"'/g' -i /assets/config/db.properties
    sed 's/{{DB_HOST}}/'"${DB_HOST}"'/g' -i /assets/config/db.properties
    sed 's/{{DB_NAME}}/'"${DB_NAME}"'/g' -i /assets/config/db.properties
    sed 's/{{DB_USER}}/'"${DB_USER}"'/g' -i /assets/config/db.properties
    sed 's/{{DB_PASS}}/'"${DB_PASS}"'/g' -i /assets/config/db.properties
    cp -f /assets/config/db.properties ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes
    cp -f /assets/config/db.properties ${CATALINA_HOME}/webapps/activiti-explorer/WEB-INF/classes
    ;;
esac

catalina.sh run
