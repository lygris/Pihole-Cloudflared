FROM pihole/pihole:development
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/bin/cloudflared
RUN chmod +x /usr/bin/cloudflared
RUN cloudflared service install eyJhIjoiY2JlOGIyOTNlZGJmOGZhMTlkMDc2OWI1ZGIxYmI3MGMiLCJ0IjoiNDNiMjc1ZTgtZTU3Yy00ZDQ0LWE0YzgtODFkNTZmZWM2NWZkIiwicyI6IlptUXpNek14TVRrdE5UTmhNeTAwT1RJeExXSXlNall0WkRObE16Um1PV000TURnNSJ9
RUN sed -i '2i nohup bash -c cloudflared proxy-dns --port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query --address 0.0.0.0 &' /usr/bin/start.sh
ENTRYPOINT [ "start.sh" ]