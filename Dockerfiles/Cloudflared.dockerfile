FROM cloudflare/cloudflared:2022.6.3-amd64

ENV TUNNEL_TOKEN=TUNNEL_TOKEN

COPY config.yaml /config.yaml

COPY credentials.json /credentials.json

RUN sysctl -w net.core.rmem_max=2500000

#CMD["sh"]
CMD ["tunnel", "--config", "/config.yaml", "--no-autoupdate", "run"]