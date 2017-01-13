FROM openshift/base-centos7 
MAINTAINER Marcel Wysocki <mwysocki@redhat.com>
EXPOSE 8080

USER root
RUN yum -y install httpd && yum clean all
RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
RUN echo 'foo bar' >/var/www/html/index.html
RUN chmod -R a+rwx /run/httpd /etc/httpd/logs /var/www/html
COPY ./s2i/ $STI_SCRIPTS_PATH
USER 1001
CMD $STI_SCRIPTS_PATH/usage
