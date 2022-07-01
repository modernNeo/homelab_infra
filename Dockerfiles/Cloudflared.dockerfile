FROM cloudflare/cloudflared:2022.6.3-amd64


COPY cloudflare_configs/config.yaml /config.yaml
COPY cloudflare_configs/credentials.json /credentials.json

CMD ["tunnel", "--no-autoupdate", "run"]