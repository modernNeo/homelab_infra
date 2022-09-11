# private_network

## Launching Cloudflared Network

### Launching code
1. [Follow instructions for creating Cloudflare Tunnel](cloudflare_configs)
    * For Tunnels created via the browser, you need to just use the `env_file` key in the `docker-compose.yml` file to pass the `TUNNEL_TOKEN` by setting it in the [`cloudflare_configs/cloudflare.env`](cloudflare_configs) file and [`docker-compose.yml` file](https://github.com/modernNeo/modernneo.com_infra/blob/68f72095ca95e9bb477552da5c94bc03e51769c7/docker-compose-cloudflared.yml#L6)
    * Otherwise, you will need to `COPY` the `config.yaml` and `credentials.json` in the [cloudflared Dockerfile](Cloudflared.dockerfile) and create the files in the [`cloudflare_configs` directory](cloudflare_configs)
2. `docker-compose -f docker-compose-cloudflared.yml up --force-recreate -d`

### Necessary Changes to Nextcloud

Necessary changes to make the `/var/www/html/config/config.php`
```
'trusted_domains' =>
array (
  0 => 'the.fqdn.com',
  1 => 'lan_name.local:8888',
),

'overwriteprotocol' => 'https',
```

### Documentation
 - [Set up a tunnel remotely (Dashboard setup)](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/#set-up-a-tunnel-remotely-dashboard-setup)  
 - [Cloudflare Home](https://dash.cloudflare.com)  
 - [Cloudflare Zero Trust](https://dash.teams.cloudflare.com)

## [Build Monero Image](https://github.com/modernNeo/monero#installing-monero-from-a-package)
