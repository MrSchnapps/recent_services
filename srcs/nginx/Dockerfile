FROM alpine:3.12

RUN apk update \
&& apk upgrade \
&& apk add nginx \
&& apk add openrc \
&& apk add openssh \
&& apk add openssl \
&& apk add curl

#Create user
#RUN adduser -D -g 'www' www

RUN mkdir /www
#RUN chown -R www:www /var/lib/nginx
#RUN chown -R www:www /www

RUN mkdir -p /run/nginx
COPY srcs/index.html /www/index.html
RUN rm /etc/nginx/conf.d/default.conf 
COPY srcs/nginx.conf /etc/nginx/conf.d/nginx.conf

#COPY srcs/nginx.conf /etc/nginx/nginx.conf
#COPY srcs/index.html /www/index.html

#ssh user and ssl key
RUN mkdir -p /etc/ssl/certs/private
#RUN adduser -D user
#RUN echo "user:password"|chpasswd
RUN ssh-keygen -A
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/private/ssl_nginx.key -out /etc/ssl/certs/ssl_nginx.certs

#RUN curl 'https://dl.influxdata.com/telegraf/releases/telegraf-1.16.0_linux_i386.tar.gz' > telegraf.tar.gz && \
   # tar xvf telegraf.tar.gz && \
    #mv 'telegraf-1.16.0' telegraf
#COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 22
EXPOSE 80
EXPOSE 443

COPY srcs/init.sh /
RUN chmod +x init.sh

CMD /init.sh
