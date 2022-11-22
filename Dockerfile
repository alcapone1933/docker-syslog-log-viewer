FROM alcapone1933/ubuntu:20.04
LABEL maintainer="alcapone1933 alcapone1933@cosanostra-cloud.de"
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install -yqq git nginx rsyslog supervisor php7.4-fpm php7.4-cli php7.4-mbstring apache2-utils && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i '1idaemon off;' /etc/nginx/nginx.conf
RUN rm -rf /var/www && git clone https://github.com/alcapone1933/PimpMyLog.git /var/www
RUN sed -i -e 's/;daemonize\ =\ yes/daemonize\ =\ no/' /etc/php/7.4/fpm/php-fpm.conf
RUN sed -i 's/^variables_order\ =.*/variables_order\ =\ \"GPCSE\"'/ /etc/php/7.4/fpm/php.ini
RUN sed -i 's/^variables_order\ =.*/variables_order\ =\ \"GPCSE\"'/ /etc/php/7.4/cli/php.ini
RUN mkdir -p /var/log/net/ && touch /var/log/net/syslog.log && ln -s /var/log/net/syslog.log /var/www/
RUN chown -R syslog:adm /var/log/net/
RUN adduser www-data adm

COPY nginx-default /etc/nginx/sites-enabled/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config.user.php /var/www/
COPY rsyslog.conf /etc/rsyslog.conf
COPY create-user.php /var/www/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh 

RUN chmod 0755 /usr/local/bin/entrypoint.sh

VOLUME ["/var/www/"]
VOLUME ["/var/log/net/"]
EXPOSE 80 514/udp

ENTRYPOINT [ "entrypoint.sh" ]
