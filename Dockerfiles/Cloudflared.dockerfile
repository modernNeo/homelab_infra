FROM cloudflare/cloudflared:2022.1.3-amd64

ENV TUNNEL_TOKEN=TUNNEL_TOKEN

COPY config.yaml /root/.cloudflared/config.yaml

COPY 0f8fe83c-f195-4422-a0ef-55afadd3b793.json /root/.cloudflared/0f8fe83c-f195-4422-a0ef-55afadd3b793.json

#CMD["sh"]
CMD ["tunnel", "--config", "/root/.cloudflared/config.yaml", "--no-autoupdate", "run"]