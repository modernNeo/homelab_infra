FROM cloudflare/cloudflared:2022.6.3-amd64

COPY cloudflare_configs/credentials.json /etc/cloudflared/credentials.json

COPY cloudflare_configs/config.yaml /etc/cloudflared/config.yml

CMD ["tunnel", "--no-autoupdate", "run"]