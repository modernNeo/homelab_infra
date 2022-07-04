FROM cloudflare/cloudflared:2022.6.3-amd64

#COPYs are not necessary if the tunnel was created via the UI
COPY cloudflare_configs/credentials.json /etc/cloudflared/credentials.json

COPY cloudflare_configs/config.yaml /etc/cloudflared/config.yaml

CMD ["tunnel", "--no-autoupdate", "run"]