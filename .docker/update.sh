export ipv6=$(ip -6 route show | grep 256 |  awk '{print $1}' | grep / | grep -v fe | awk 'ORS=","')
export ipv4=$(ip -4 route show | grep / | grep br | awk '{print $1}'| awk 'ORS=","')
export ipv6PD=$(ip -6 a show dev br2 | grep /64 | grep -v fe | awk '{print $2}' | awk -F: '{ print $1":"$2":"$3":"$4+10"::/64" }')
export ts6=$(ip -6 route show | grep 256 |  awk '{print $1}' | grep / | grep -v fe | awk 'ORS="\",\""')
export ts4=$(ip -4 route show | grep / | grep br | awk '{print $1}'| awk 'ORS="\",\""')
export tsPD=$(ip -6 a show dev br2 | grep /64 | grep -v fe | awk '{print $2}' | awk -F: '{ print $1":"$2":"$3":"$4+10"::/64\"" }')
export routes=$ipv4$ipv6$ipv6PD
export tsRoutes="\""$ts4$ts6$tsPD
sudo echo "routes=$routes" > /data/host.env
sudo echo "ipv6PD=$ipv6PD" >> /data/host.env
curl --request POST \
  --url https://api.tailscale.com/api/v2/device/niW51x5hbj11CNTRL/routes \
  --header 'Authorization: Bearer '$TSAPIKEY'' \
  --header 'Content-Type: application/json' \
  --data '{
  "routes": [
    '$tsRoutes'
  ]
}'
sudo ipset create -! docker_lan_routable_net_set6 hash:net family inet6
sudo ipset add -! docker_lan_routable_net_set6 '$ipv6PD'
sudo ipset create -! docker_lan_routable_net_set6 hash:net family inet6
sudo ipset add -! docker_wan_routable_net_set6 '$ipv6PD'
sudo ip -6 route add '$ipv6PD' dev br-$(sudo docker network inspect pihole |jq -r '.[0].Id[0:12]') table lan_routable
sudo ip -6 route add '$ipv6PD' dev br-$(sudo docker network inspect pihole |jq -r '.[0].Id[0:12]') table wan_routable
docker compose --env-file=.env pull
docker compose --env-file=.env down
docker compose --env-file=.env up -d