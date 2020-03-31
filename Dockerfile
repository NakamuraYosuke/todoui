FROM registry.access.redhat.com/ubi8:8.0

LABEL version="1.0" \
  description="To Do List application front-end"

ENV BACKEND_HOST=todoapi-todoapp.apps-crc.testing

RUN yum install -y --disableplugin=subscription-manager --nodocs \
  nginx nginx-mod-http-perl \
  && yum clean all

COPY nginx.conf /etc/nginx/

RUN touch /run/nginx.pid \
  && chgrp -R 0 /var/log/nginx /run/nginx.pid \
  && chmod -R g+rwx /var/log/nginx /run/nginx.pid
  
COPY src/ /usr/share/nginx/html

EXPOSE 8090

USER 1001

CMD nginx -g "daemon off;"

