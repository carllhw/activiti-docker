FROM tomcat:9-jdk11-adoptopenjdk-openj9

ENV ACTIVITI_VERSION 5.21.0
ENV MYSQL_CONNECTOR_JAVA_VERSION 5.1.49

RUN wget https://github.com/Activiti/Activiti/releases/download/activiti-${ACTIVITI_VERSION}/activiti-${ACTIVITI_VERSION}.zip -O /tmp/activiti.zip && \
 	unzip /tmp/activiti.zip -d /opt/activiti && \
	unzip /opt/activiti/activiti-${ACTIVITI_VERSION}/wars/activiti-explorer.war -d ${CATALINA_HOME}/webapps/activiti-explorer && \
	unzip /opt/activiti/activiti-${ACTIVITI_VERSION}/wars/activiti-rest.war -d ${CATALINA_HOME}/webapps/activiti-rest && \
	rm -f /tmp/activiti.zip

RUN wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}.zip -O /tmp/mysql-connector-java.zip && \
	unzip /tmp/mysql-connector-java.zip -d /tmp && \
	cp /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}-bin.jar ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/lib/ && \
	cp /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}-bin.jar ${CATALINA_HOME}/webapps/activiti-explorer/WEB-INF/lib/ && \
	rm -rf /tmp/mysql-connector-java.zip /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}

ADD assets /assets
RUN cp /assets/config/tomcat/tomcat-users.xml ${CATALINA_HOME}/conf/

CMD ["/assets/init"]
