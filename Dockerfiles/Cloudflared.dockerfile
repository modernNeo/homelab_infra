FROM cloudflare/cloudflared:2022.6.3-amd64

ENV TUNNEL_TOKEN=TUNNEL_TOKEN

COPY config.yaml /config.yaml

COPY 885aa5c1-7648-47aa-b462-3204735b6409.json /885aa5c1-7648-47aa-b462-3204735b6409.json

#CMD["sh"]
CMD ["tunnel", "--config", "/config.yaml", "--no-autoupdate", "run"]