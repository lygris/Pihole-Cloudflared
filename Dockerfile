FROM pihole/pihole:development
RUN apk update && apk upgrade && apk add unbound
COPY unbound.conf /etc/unbound/unbound.conf
RUN mkdir -p /etc/unbound
COPY unbound-run /etc/unbound/run
RUN chmod +x /etc/unbound/run
RUN touch /var/log/unbound.log
RUN chmod 777 /var/log/unbound.log
RUN sed -i '2i nohup bash -c unbound &' /usr/bin/start.sh
RUN wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints
RUN sed -i '2i unbound-anchor -a /etc/unbound/root.key' /usr/bin/start.sh
RUN chown -R unbound:unbound /etc/unbound
ENTRYPOINT [ "start.sh" ]