# private_network

- [Specs](#specs)
  - [Main Machine](#main-machine)
    - [Software](#software)
    - [Hardware](#hardware)
  - [NAS](#nas)
- [Setup NFS](#setup-nfs)
- [Setting up Docker Root to use Home Directory](#setting-up-docker-root-to-use-home-directory)
- [Launching Services](#launching-services)
  - [Cloudflared](#cloudflared)
    - [Creating Cloudflared Network](#creating-cloudflared-network)
      - [Relevant Cloudflare Links](#relevant-cloudflare-links)
    - [Launching Cloudflare](#launching-cloudflare)
      - [Necessary Files](#necessary-files)
  - [NextCloud](#nextcloud)
    - [Setup Desktop Clients for File Syncing](#setup-desktop-clients-for-file-syncing)
  - [Jenkins](#jenkins)
- [Build Monero Image](#build-monero-image)

# Specs
## Main Machine
### Software
  - Debian GNU/Linux 12 (bookworm)
    - with Cinnamon Desktop environment instead of GNOME
  - Docker version 26.1.3, build b72abbb
    - [Install Instructions](https://docs.docker.com/engine/install/debian/)
  - [xrdp](https://github.com/neutrinolabs/xrdp)
    - [Install Instructions](https://www.digitalocean.com/community/tutorials/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04)
    - [Configure to use with Cinnamon Desktop Environment](https://askubuntu.com/a/289672)
### Hardware
 - [Intel NUC 12 Pro Kit](https://www.newegg.ca/rnuc12wski70000-intel-nuc-12-pro-wall-street-canyon-i7-slim/p/N82E16856102364?Item=N82E16856102364)
 - [Crucial 64GB Kit (32GBx2)](https://www.newegg.ca/crucial-64gb-260-pin-ddr4-so-dimm/p/N82E16820156242?Item=9SIADGEEVT2508)
 - [WD_BLACK SN850X NVMe M.2 2280 2TB](https://www.newegg.ca/western-digital-2tb-black-sn850x-nvme/p/N82E16820250247)
## NAS
 - [Synology 2 bay NAS DiskStation DS220+](https://www.amazon.ca/gp/product/B087ZCBWFH/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&th=1)
 - [Western Digital 2TB WD Red Plus NAS Internal Hard Drive HDD](https://www.amazon.ca/gp/product/B08VH891FS/ref=ppx_od_dt_b_asin_title_s00?ie=UTF8&psc=1)
# Setup NFS
 - [Setup NFS Shared Folder on Synology](https://kb.synology.com/en-us/DSM/tutorial/How_to_access_files_on_Synology_NAS_within_the_local_network_NFS#7MrLJcRf6d)
# Setting up Docker Root to use Home Directory
I was originally planning to have the docker resources located on the NFS share so that if docker/the nuc does down, it's entire state is preserved on the NAS with RAID but the only storage driver Docker has for dealing with NFS file systems is [vfs and fuse-overlayfs](https://docs.docker.com/storage/storagedriver/select-storage-driver/#supported-backing-filesystems) and the performance hit of `vfs` [as `fuse-overlayfs` does [not seem recommended on Debian](https://docs.docker.com/storage/storagedriver/select-storage-driver/#supported-storage-drivers-per-linux-distribution)] compared to using `overlay2` is incredible. As a result, I decided to just have the docker data on the home directory as my home directory has far more space than my `/var` folder while all the docker containers will have their "data" folders mounted to an NFS mountpoint
```
/etc/docker/daemon.json 
{
	"data-root": "/home/jace/docker_data"
}
```
```bash
mkdir -p /home/jace/nas_mount
sudo mount -t nfs -o nfsvers=4.1  nas.local:/volume1/main_drive /home/jace/nas_mount
```
# Launching Services
## Cloudflared
### Creating Cloudflared Network
>If you have already have the necessary files as outlined [here](#necessary-files), you can skip to [Launching Cloudflare](#launching-cloudflare)
1. [Follow instructions for creating Cloudflare Tunnel](cloudflare_configs)
    * For Tunnels created via the browser, you need to just use the `env_file` key in the `docker-compose.yml` file to pass the `TUNNEL_TOKEN` by setting it in the [`cloudflare_configs/cloudflare.env`](cloudflare_configs) file and [`docker-compose.yml` file](https://github.com/modernNeo/modernneo.com_infra/blob/68f72095ca95e9bb477552da5c94bc03e51769c7/docker-compose-cloudflared.yml#L6)
    * Otherwise, you will need to `COPY` the `config.yaml` and `credentials.json` in the [cloudflared Dockerfile](Cloudflared.dockerfile) and create the files in the [`cloudflare_configs` directory](cloudflare_configs)
2. `docker-compose -f docker-compose-cloudflared.yml up --force-recreate -d`
#### Relevant Cloudflare Links
 - [Set up a tunnel remotely (Dashboard setup)](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/#set-up-a-tunnel-remotely-dashboard-setup)  
 - [Cloudflare Home](https://dash.cloudflare.com)  
 - [Cloudflare Zero Trust](https://dash.teams.cloudflare.com)
### Launching Cloudflare
#### Necessary Files
  - [credentials.json](cloudflare_configs/credentials.json.example)
  - cert.pem
  - [config.yaml](cloudflare_configs/config.yaml.example)  

`docker compose -f docker-compose-cloudflared.yml up -d`
## NextCloud

you may need to manually set the trusted domains as nextcloud currently has a bug [where the env variable does not always get applied correctly](https://github.com/nextcloud/notes/issues/1187)
```bash
mkdir -p /home/jace/nas_mount/docker_data/nextcloud/postgres_data
mkdir -p /home/jace/nas_mount/docker_data/nextcloud/data

file: nextcloud.env 
POSTGRES_DB=<database_name>
POSTGRES_USER=<database_username>
POSTGRES_PASSWORD=<password>
NEXTCLOUD_TRUSTED_DOMAINS=<nextcloud FQDN specified in config.yaml> linux.local:8888
OVERWRITEPROTOCOL=https #necessary to get NextCloud Notes App Working
POSTGRES_HOST=nextcloud_postgres
REDIS_HOST=nextcloud_redis

docker compose -f docker-compose-nextcloud.yml up -d
```
### Setup Desktop Clients for File Syncing
https://nextcloud.com/install/#install-clients

If you are attemping to sync any files > 100MB using Cloudflare [as this guide does], you will see alot of error with `Connection closed` in the client due to [this error](https://help.nextcloud.com/t/if-youre-seeing-connection-closed-errors-uploading-large-files-100mb-while-using-cloudflare-we-have-a-fix/137510). That can be fixed with: https://github.com/nextcloud/desktop/issues/4278#issuecomment-1099587102
## Jenkins
`docker compose -f docker-compose-jenkins.yml up -d`
# [Build Monero Image](https://github.com/modernNeo/monero#installing-monero-from-a-package)
