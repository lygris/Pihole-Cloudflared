FROM pihole/pihole:development
RUN apk update && apk upgrade -y && apk add unbound -y
RUN rc-update add unbound default

COPY unbound.conf /etc/unbound/unbound.conf.d/pihole.conf
# RUN mkdir -p /etc/services.d/unbound
# COPY unbound-run /etc/services.d/unbound/run
# RUN chmod +x /etc/services.d/unbound/run
RUN touch /var/log/unbound.log
RUN chmod 777 /var/log/unbound.log
ENTRYPOINT [ "/s6-init" ]