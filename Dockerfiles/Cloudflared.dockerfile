FROM cloudflare/cloudflared:2022.6.3-amd64

ARG TUNNEL_TOKEN
ENV TUNNEL_TOKEN=TUNNEL_TOKEN

#COPY config.yaml /config.yaml
#
#COPY credentials.json /credentials.json

COPY run_tunnel.sh /run_tunnel.sh

#CMD["sh"]
CMD ["/run_tunnel.sh"]