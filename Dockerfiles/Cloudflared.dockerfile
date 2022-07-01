FROM cloudflare/cloudflared:2022.1.3-amd64

ENV TUNNEL_TOKEN=TUNNEL_TOKEN

#CMD["sh"]
CMD["tunnel", "--no-autoupdate", "run"]