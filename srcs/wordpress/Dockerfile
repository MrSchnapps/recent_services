FROM alpine:3.12

RUN apk update \
&& apk upgrade \
&& apk add nginx openrc curl \
    php7 php7-fpm php7-opcache \
    php7-gd php7-mysqli php7-zlib php7-curl \
    php7-mbstring php7-json php7-session \
&& curl  'https://wordpress.org/latest.tar.gz' > wordpress.tar.gz

RUN tar -xvf wordpress.tar.gz \
&& rm -rf var/www \
&& mv wordpress var/www

COPY srcs/nginx.conf /etc/nginx/conf.d
RUN mkdir -p /run/nginx \
&& rm /etc/nginx/conf.d/default.conf

COPY srcs/wp-config.php /var/www/wp-config.php

RUN curl 'https://dl.influxdata.com/telegraf/releases/telegraf-1.16.0_linux_i386.tar.gz' > telegraf.tar.gz && \
tar xvf telegraf.tar.gz && \
mv 'telegraf-1.16.0' telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY srcs/init.sh /
RUN chmod +x init.sh

EXPOSE 5050

CMD /init.sh