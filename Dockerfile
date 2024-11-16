FROM pihole/pihole:latest
RUN apt update && apt upgrade -y && apt install -y unbound

COPY unbound.conf /etc/unbound/unbound.conf.d/pihole.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run
RUN chmod +x /etc/services.d/unbound/run
RUN touch /var/log/unbound.log
RUN chmod 777 /var/log/unbound.log
ENTRYPOINT [ "/s6-init" ]