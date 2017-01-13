FROM openshift/base-centos7 
MAINTAINER Marcel Wysocki <mwysocki@redhat.com>
EXPOSE 8080

LABEL io.k8s.description="Apache S2I Image to deploy websites" \
      io.k8s.display-name="Apache" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,apache,httpd"

USER root
RUN yum -y install httpd && yum clean all
RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
RUN echo 'foo bar' >/var/www/html/index.html
RUN chmod -R a+rwx /run/httpd /etc/httpd/logs /var/www/html
COPY ./s2i/ $STI_SCRIPTS_PATH
RUN chmod -R a+rx $STI_SCRIPTS_PATH

USER 1001
CMD $STI_SCRIPTS_PATH/usage
