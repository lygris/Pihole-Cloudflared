FROM pihole/pihole:latest
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/bin/cloudflared
RUN chmod +x /usr/bin/cloudflared
RUN sed -i '83i cloudflared proxy-dns --port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query --address 0.0.0.0 > /var/log/pihole/FTL.log 2>&1 &' /usr/bin/start.sh
ENTRYPOINT [ "start.sh" ]