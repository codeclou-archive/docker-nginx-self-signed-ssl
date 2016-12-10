FROM ubuntu:16.04

#
# PACKAGES
#
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*
RUN sudo apt-get update
RUN sudo apt-get -y install nginx openssl

#
# SSL
#
RUN echo "#!/bin/bash" > /opt/generate_ssl.sh && \
    echo "" >> /opt/generate_ssl.sh  && \
    echo "cd /etc/ssl" >> /opt/generate_ssl.sh  && \
    echo "openssl genrsa -des3 -passout pass:x -out server.pass.key 2048" >> /opt/generate_ssl.sh  && \
    echo "openssl rsa -passin pass:x -in server.pass.key -out server.key" >> /opt/generate_ssl.sh  && \
    echo "rm server.pass.key" >> /opt/generate_ssl.sh  && \
    echo "openssl req -new -key server.key -out server.csr -subj \"/C=DE/ST=Nuremberg/L=Nuremberg/O=codeclou.io/OU=codeclou.io/CN=local.codeclou.io\"" >> /opt/generate_ssl.sh  && \
    echo "openssl x509 -req -sha256 -days 300065 -in server.csr -signkey server.key -out server.crt" >> /opt/generate_ssl.sh  && \
    chmod +x /opt/generate_ssl.sh


#
# NGINX CONFIG
#
RUN rm -rf /etc/nginx/sites-enabled/*  && \
    echo "server {" > /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   listen 4443;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   ssl on;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   ssl_certificate  /etc/ssl/server.crt;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   ssl_certificate_key /etc/ssl/server.key;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   ssl_session_timeout 5m;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   ssl_session_cache shared:SSL:10m;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   ssl_protocols TLSv1 TLSv1.1 TLSv1.2;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   ssl_prefer_server_ciphers on;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   add_header Strict-Transport-Security 'max-age=63072000; includeSubdomains; '; " >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   add_header X-Frame-Options 'DENY';" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   server_name local.codeclou.io;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   index index.html index.htm;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "   root /opt/www;" >> /etc/nginx/sites-enabled/local.codeclou.io.conf  && \
    echo "}" >> /etc/nginx/sites-enabled/local.codeclou.io.conf

#
# EXPOSE www
#
RUN mkdir /opt/www
WORKDIR /opt/www/

#
# RUN CMD
#
RUN echo "#!/bin/bash"               > /opt/run.sh && \
    echo ""                         >> /opt/run.sh && \
    echo "/opt/generate_ssl.sh"     >> /opt/run.sh && \
    echo "nginx -g \"daemon off;\"" >> /opt/run.sh && \
    chmod +x /opt/run.sh

#
# RUN NGINX
#
CMD ["/opt/run.sh"]
EXPOSE 4443
