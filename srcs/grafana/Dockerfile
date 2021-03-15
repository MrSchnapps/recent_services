FROM alpine:3.12

RUN apk update \
&& apk upgrade \
&& apk add libc6-compat curl \
&& curl 'https://dl.grafana.com/oss/release/grafana-7.2.1.linux-amd64.tar.gz' > grafana.tar.gz

RUN tar xvf grafana.tar.gz \
&& mv grafana-7.2.1 grafana

RUN curl 'https://dl.influxdata.com/telegraf/releases/telegraf-1.16.0_linux_i386.tar.gz' > telegraf.tar.gz && \
tar xvf telegraf.tar.gz && \
mv 'telegraf-1.16.0' telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY srcs/grafana.db /grafana/data/grafana.db
COPY srcs/init.sh /
RUN chmod +x init.sh

COPY srcs/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/

EXPOSE 3000

CMD /init.sh
