FROM cloudflare/cloudflared:2022.6.3-amd64


COPY config.yaml /config.yaml
COPY credentials.json /credentials.json

#CMD["sh"]
CMD ["tunnel", "--no-autoupdate", "run"]