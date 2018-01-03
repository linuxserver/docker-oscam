[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: http://www.streamboard.tv/oscam/
[hub]: https://hub.docker.com/r/linuxserver/oscam/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/oscam
[![](https://images.microbadger.com/badges/version/linuxserver/oscam.svg)](https://microbadger.com/images/linuxserver/oscam "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/oscam.svg)](https://microbadger.com/images/linuxserver/oscam "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/oscam.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/oscam.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-oscam)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-oscam/)

[Oscam][appurl] is an Open Source Conditional Access Module software used for descrambling DVB transmissions using smart cards. It's both a server and a client.

[![oscam](http://download.oscam.cc/images/Logo.png)][appurl]

## Usage

```
docker create \
  --name=oscam \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8888:8888 \
  --device=/dev/ttyUSB0 \
  linuxserver/oscam
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 8888` - the port(s)
* `-v /config` - where oscam should store config files and logs
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `--device=/dev/ttyUSB0` - for passing through smart card readers

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it oscam /bin/bash`.

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

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

To set up oscam there are numerous guides on the internet. There are too many scenarios to make a quick guide.
The web interface is at port 8888.


## Info

* Shell access whilst the container is running: `docker exec -it oscam /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f oscam`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' oscam`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/oscam`

## Versions

+ **03.01.18:** Deprecate cpu_core routine lack of scaling.
+ **13.12.17:** Rebase to alpine 3.7.
+ **19.10.17:** Add ccid package for usb card readers.
+ **17.10.17:** Switch to using bzr for source code, streamboard awol.
+ **28.05.17:** Rebase to alpine 3.6.
+ **09.02.17:** Rebase to alpine 3.5.
+ **14.10.16:** Add version layer information.
+ **02.10.16:** Add info on passing through devices to README.
+ **25.09.16:** Initial release.
