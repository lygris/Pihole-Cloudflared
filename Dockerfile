FROM pihole/pihole:development
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/bin/cloudflared
RUN chmod +x /usr/bin/cloudflared
RUN sed -i '2i nohup bash -c cloudflared proxy-dns --port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query --address 0.0.0.0 &' /usr/bin/start.sh
RUN sed -i '2i cloudflared service install $token'
ENTRYPOINT [ "start.sh" ]