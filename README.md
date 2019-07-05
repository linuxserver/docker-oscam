[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/oscam](https://github.com/linuxserver/docker-oscam)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/oscam.svg)](https://microbadger.com/images/linuxserver/oscam "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/oscam.svg)](https://microbadger.com/images/linuxserver/oscam "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/oscam.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/oscam.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-oscam/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-oscam/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/oscam/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/oscam/latest/index.html)

[Oscam](http://www.streamboard.tv/oscam/) is an Open Source Conditional Access Module software used for descrambling DVB transmissions using smart cards. It's both a server and a client.

[![oscam](http://download.oscam.cc/images/Logo.png)](http://www.streamboard.tv/oscam/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/oscam` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=oscam \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 8888:8888 \
  -v <path to data>:/config \
  --device /dev/ttyUSB0:/dev/ttyUSB0 \
  --restart unless-stopped \
  linuxserver/oscam
```

### Passing through Smart Card Readers

If you want to pass through a smart card reader, you need to specify the reader with the `--device=` tag. The method used depends on how the reader is recognized.
The first is /dev/ttyUSBX. To find the correct device, connect the reader and run `dmesg | tail` on the host. In the output you will find /dev/ttyUSBX, where X is the number of the device. If this is the first reader you connect to your host, it will be /dev/ttyUSB0. If you add one more it will be /dev/ttyUSB1.

If there are no /dev/ttyUSBX device in `dmesg | tail`, you have to use the USB bus path. It will look similar to the below.

`/dev/bus/usb/001/001`

The important parts are the two numbers in the end. The first one is the Bus number, the second is the Device number. To find the Bus and Device number you have to run `lsusb` on the host, then find your USB device in the list and note the Bus and Device numbers.

Here is an example of how to find the Bus and Device. The output of the lsusb command is below.

`Bus 002 Device 005: ID 076b:6622 OmniKey AG CardMan 6121`

The first number, the Bus, is 002. The second number, the Device, is 005. This will look like below in the `--device=` tag.

`--device=/dev/bus/usb/002/005`

If you have multiple smart card readers, you add one `--device=` tag for each reader.


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  oscam:
    image: linuxserver/oscam
    container_name: oscam
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
    ports:
      - 8888:8888
    devices:
      - /dev/ttyUSB0:/dev/ttyUSB0
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8888` | WebUI |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /config` | Where oscam should store config files and logs. |
| `--device /dev/ttyUSB0` | For passing through smart card readers. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

To set up oscam there are numerous guides on the internet. There are too many scenarios to make a quick guide.
The web interface is at port 8888.



## Support Info

* Shell access whilst the container is running: `docker exec -it oscam /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f oscam`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' oscam`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/oscam`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/oscam`
* Stop the running container: `docker stop oscam`
* Delete the container: `docker rm oscam`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start oscam`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull oscam`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d oscam`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once oscam
  ```

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using Docker Compose.

* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-oscam.git
cd docker-oscam
docker build \
  --no-cache \
  --pull \
  -t linuxserver/oscam:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **29.04.19:** - Add revision check, so pipeline can build new revisions.
* **28.04.19:** - Switch back to streamboard svn to fix version not showing in UI.
* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **19.02.19:** - Add pipeline logic and multi arch, rebase to Alpine 3.8.
* **03.01.18:** - Deprecate cpu_core routine lack of scaling.
* **13.12.17:** - Rebase to alpine 3.7.
* **19.10.17:** - Add ccid package for usb card readers.
* **17.10.17:** - Switch to using bzr for source code, streamboard awol.
* **28.05.17:** - Rebase to alpine 3.6.
* **09.02.17:** - Rebase to alpine 3.5.
* **14.10.16:** - Add version layer information.
* **02.10.16:** - Add info on passing through devices to README.
* **25.09.16:** - Initial release.
