FROM tomcat:9.0.41-jdk11
COPY ./web.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh", "run"]