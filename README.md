# private_network

## Launching code
1. [Follow instructions for creating Cloudflare Tunnel](cloudflare_configs)
    * For Tunnels created via the browser, you need to just use the `env_file` key in the `docker-compose.yml` file to pass the `TUNNEL_TOKEN` by setting it in the [`cloudflare_configs/cloudflare.env`](cloudflare_configs) file and [`docker-compose.yml` file](https://github.com/modernNeo/private_network/blob/master/docker-compose.yml#L14)
    * Otherwise, you will need to `COPY` the `config.yaml` and `credentials.json` in the [cloudflared Dockerfile](Dockerfiles/Cloudflared.dockerfile) and create the files in the [`cloudflare_configs` directory](cloudflare_configs) 
2. [Update the nginx configs to match](nginx_configs):
   1. `server` -> `container_name` from `docker-compose.yml`
   2. `port` -> port that application is running on in its docker container
   3. `server_name` -> the hostname set in [Cloudflare configuration](cloudflare_configs)
3. `docker-compose -f docker-compose.yml up --force-recreate -d`

## Documentation
 - [Set up a tunnel remotely (Dashboard setup)](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/#set-up-a-tunnel-remotely-dashboard-setup)  
 - [Cloudflare Home](https://dash.cloudflare.com)  
 - [Cloudflare Zero Trust](https://dash.teams.cloudflare.com)
