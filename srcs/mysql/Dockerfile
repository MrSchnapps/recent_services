FROM alpine:3.12

RUN apk update \
&& apk upgrade \
&& apk add mysql mysql-client curl

#RUN curl 'https://dl.influxdata.com/telegraf/releases/telegraf-1.16.0_linux_i386.tar.gz' > telegraf.tar.gz && \
    #tar xvf telegraf.tar.gz && \
   # mv 'telegraf-1.16.0' telegraf
#COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY srcs/init.sh /
RUN chmod +x init.sh

CMD /init.sh