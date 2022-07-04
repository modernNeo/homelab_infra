
[Access Tunnels Resources](https://dash.teams.cloudflare.com)   
[Documentation for Setting up Cloudflare Tunnels](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)

## Generate Tunnel from cli

>Adapted from https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/#set-up-a-tunnel-locally-cli-setup
```shell
docker exec -it ubuntu_container bash
cloudflared tunnel login
cloudflared tunnel create <tunnel_name>
cloudflared tunnel route dns <tunnel_name> <hostname>
exit
docker cp ubuntu_container:/root/.cloudflared/52e3ce80-0e31-4745-aa83-83c2490df284.json cloudflare_configs/credentials.json
chmod o+r cloudflare_configs/credentials.json
```

## Generate Tunnel from UI

### Generate .Env file

 1. go to https://dash.teams.cloudflare.com
 2. `Access` -> `Tunnels` -> Click on `Configure` for tunnel 
 3. get the token from the command `sudo cloudflared service install <TOKEN>` on the website
 4. Place token in `cloudflare.env`

### Getting credentials for tunnel generated from UI
>Adapted from 
> * https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/#set-up-a-tunnel-locally-cli-setup
> * https://github.com/cloudflare/cloudflared/issues/645#issuecomment-1127393680
```shell
docker exec -it ubuntu_container bash
apt-get update
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && sudo dpkg -i cloudflared.deb && 

cloudflared service install ${TOKEN}
cloudflared tunnel list
cloudflared tunnel token --cred-file credentials.json <Tunnel UUID>
exit
docker cp ubuntu_container:/credentials.json /var/services/homes/jace/private_network/cloudflare_configs/credentials.json
cloudflare_configs/credentials.json
```