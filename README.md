# private_network


`docker-compose -f docker-compose.yml up --force-recreate -d`

## Documentation
 - [Set up a tunnel remotely (Dashboard setup)](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/#set-up-a-tunnel-remotely-dashboard-setup)  
 - [Cloudflare Home](https://dash.cloudflare.com)  
 - [Cloudflare Zero Trust](https://dash.teams.cloudflare.com)

## Launching code
For Tunnels created via the browser, you need to just use the `env_file` key in the docker-compose.yml file to pass the `TUNNEL_TOKEN`. Otherwise, you will need to specify the `config.yaml` and `credentials.json` in the `cloudflare-configs`

