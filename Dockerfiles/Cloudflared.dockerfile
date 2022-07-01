FROM cloudflare/cloudflared:2022.6.3-amd64

#ENV TUNNEL_TOKEN=TUNNEL_TOKEN

COPY config.yaml /config.yaml
#
COPY credentials.json /credentials.json

#CMD["sh"]
CMD ["tunnel", "--no-autoupdate", "run"]