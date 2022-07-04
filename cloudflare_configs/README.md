
[Access Tunnels Resources](https://dash.teams.cloudflare.com)   
[Documentation for Setting up Cloudflare Tunnels](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)

## Generate .Env file

 1. go to https://dash.teams.cloudflare.com
 2. `Access` -> `Tunnels` -> Click on `Configure` for tunnel 
 3. get the token from the command `sudo cloudflared service install <TOKEN>` on the website
 4. Place token in `cloudflare.env`

## Generate Tunnel from cli

>Adapted from https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/#set-up-a-tunnel-locally-cli-setup
```shell
cloudflared tunnel create <tunnel_name>
cloudflared tunnel route dns <tunnel_name> <hostname>
```

## Getting credentials for tunnel generated from UI
>Adapted from 
> * https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/#set-up-a-tunnel-locally-cli-setup
> * https://github.com/cloudflare/cloudflared/issues/645#issuecomment-1127393680
```shell
docker exec -it ubuntu_container bash
apt-get update
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && sudo dpkg -i cloudflared.deb && 

cloudflared service install ${TOKEN}
cloudflared tunnel login
cloudflared tunnel list
cloudflared tunnel token --cred-file credentials.json <Tunnel UUID>
exit
docker cp ubuntu_container:/credentials.json /var/services/homes/jace/private_network/cloudflare_configs/credentials.json
```