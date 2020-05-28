#!/bin/bash
set -e
set -x

DB_PORT=${DB_PORT:-3306}
sed 's/{{DB_PORT}}/'"${DB_PORT}"'/g' -i /assets/config/db.properties /assets/config/activiti-app.properties
sed 's/{{DB_HOST}}/'"${DB_HOST}"'/g' -i /assets/config/db.properties /assets/config/activiti-app.properties
sed 's/{{DB_NAME}}/'"${DB_NAME}"'/g' -i /assets/config/db.properties /assets/config/activiti-app.properties
sed 's/{{DB_USER}}/'"${DB_USER}"'/g' -i /assets/config/db.properties /assets/config/activiti-app.properties
sed 's/{{DB_PASS}}/'"${DB_PASS}"'/g' -i /assets/config/db.properties /assets/config/activiti-app.properties
cp -f /assets/config/db.properties ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes
cp -f /assets/config/activiti-app.properties ${CATALINA_HOME}/webapps/activiti-app/WEB-INF/classes/META-INF/activiti-app

catalina.sh run
