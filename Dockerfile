FROM tomcat:9-jdk8-adoptopenjdk-openj9

ENV ACTIVITI_VERSION 5.22.0
ENV MYSQL_CONNECTOR_JAVA_VERSION 5.1.49

# Add mirror source
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    sed -i 's http://.*.ubuntu.com http://mirrors.aliyun.com g' /etc/apt/sources.list

# Install base packages
RUN apt-get update && apt-get install -y \
         vim \
         tar \
         zip \
         curl \
         wget \
         gzip \
         unzip \
         bzip2 \
         gnupg \
         netcat \
         dirmngr \
         locales \
         net-tools \
         fontconfig \
         openssh-client \
         ca-certificates && \
      rm -rf /var/lib/apt/lists/* && \
    wget -qO /tmp/activiti.zip "https://github.com/Activiti/Activiti/releases/download/activiti-${ACTIVITI_VERSION}/activiti-${ACTIVITI_VERSION}.zip" && \
 	unzip -q /tmp/activiti.zip -d /tmp && \
	unzip -q "/tmp/activiti-${ACTIVITI_VERSION}/wars/activiti-explorer.war" -d "${CATALINA_HOME}/webapps/activiti-explorer" && \
	unzip -q "/tmp/activiti-${ACTIVITI_VERSION}/wars/activiti-rest.war" -d "${CATALINA_HOME}/webapps/activiti-rest" && \
	rm -rf /tmp/activiti.zip "/tmp/activiti-${ACTIVITI_VERSION}" && \
    wget -qO /tmp/mysql-connector-java.zip "http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}.zip" && \
	unzip -q /tmp/mysql-connector-java.zip -d /tmp && \
	cp "/tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}-bin.jar" "${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/lib/" && \
	cp "/tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}-bin.jar" "${CATALINA_HOME}/webapps/activiti-explorer/WEB-INF/lib/" && \
	rm -rf /tmp/mysql-connector-java.zip "/tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}"

ADD assets /assets

CMD ["/assets/init.sh"]
