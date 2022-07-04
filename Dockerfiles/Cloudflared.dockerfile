FROM cloudflare/cloudflared:2022.6.3-amd64

WORKDIR /etc/cloudflared/

COPY cloudflare_configs/credentials.json credentials.json

COPY cloudflare_configs/config.yaml config.yml

CMD ["tunnel", "--no-autoupdate", "run"]