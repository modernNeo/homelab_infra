FROM cloudflare/cloudflared:2022.6.3-amd64

COPY run_tunnel.sh /run_tunnel.sh

#CMD["sh"]
CMD ["/run_tunnel.sh"]