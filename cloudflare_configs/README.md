

# Generate .Env file

 1. go to https://dash.teams.cloudflare.com
 2. `Access` -> `Tunnels` -> Click on `Configure` for tunnel 
 3. get the token from the command `sudo cloudflared service install <TOKEN>` on the website
 4. Place token in `cloudflare.env`

# Generate Credentials file

Run from inside docker container ubuntu
```shell
docker exec -it ubuntu_container bash
apt-get update
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && sudo dpkg -i cloudflared.deb && 

cloudflared service install ${TOKEN}
cloudflared tunnel login
cloudflared tunnel token --cred-file credentials.json <Tunnel UUID>
```
copy the credentials.json file to cloudflare_configs

# Generate Config.yaml file

 1. Populate `config.yaml` with
```shell
url: http://nginx:8000
tunnel: <Tunnel UUID>
credentials-file: /credentials.json
```