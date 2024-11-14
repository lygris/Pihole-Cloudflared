FROM pihole/pihole:latest
RUN apt update && apt upgrade -y && apt install -y unbound

COPY unbound.conf /etc/unbound/unbound.conf.d/pihole.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run
ENTRYPOINT [ "/s6-init" ]