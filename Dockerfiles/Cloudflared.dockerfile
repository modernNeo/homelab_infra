FROM cloudflare/cloudflared:2022.1.3-amd64

ENV TUNNEL_TOKEN=TUNNEL_TOKEN

COPY config.yaml /config.yaml

#CMD["sh"]
CMD ["tunnel", "--config", "/config.yaml", "--no-autoupdate", "run"]