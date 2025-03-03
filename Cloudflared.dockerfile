FROM cloudflare/cloudflared:2025.2.1-amd64

#COPYs are not necessary if the tunnel was created via the UI
COPY cloudflare_configs/credentials.json /etc/cloudflared/credentials.json

COPY cloudflare_configs/cert.pem /etc/cloudflared/cert.pem

COPY cloudflare_configs/config.yaml /etc/cloudflared/config.yaml

CMD ["tunnel", "--no-autoupdate", "run"]
# CMD ["tunnel", "--loglevel", "debug", "--no-autoupdate", "run"]