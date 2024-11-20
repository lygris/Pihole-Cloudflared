FROM pihole/pihole:development
RUN apk update && apk upgrade && apk add unbound
COPY unbound.conf /etc/unbound/unbound.conf.d/pihole.conf
RUN mkdir -p /etc/unbound
COPY unbound-run /etc/unbound/run
RUN chmod +x /etc/unbound/run
RUN touch /var/log/unbound.log
RUN chmod 777 /var/log/unbound.log
ENTRYPOINT [ "/s6-init" ]