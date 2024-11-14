FROM pihole/pihole:latest
RUN apt update && apt upgrade && apt install -y unbound

COPY unbound.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY start_unbound_and_s6_init.sh start_unbound_and_s6_init.sh

RUN echo "/etc/init.d/unbound start" >> s6-init
ENTRYPOINT [ "/s6-init" ]