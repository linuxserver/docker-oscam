![https://linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring auto-update on startup, easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](https://forum.linuxserver.io)
* [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`
* [Podcast](https://www.linuxserver.io/index.php/category/podcast/) covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/oscam

[Oscam] (http://www.streamboard.tv/oscam/) is an Open Source Conditional Access Module software used for descrambling DVB transmissions using smart cards. It's both a server and a client.


## Usage

```
docker create \
  --name=oscam \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8888:8888 \
  linuxserver/oscam
```
If you pass through a card reader, add the --device=/path/to/cardreader tag.

**Parameters**

* `-p 1234` - the port(s)
* `-v /config` - explain what lives here
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it <container-name> /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

To set up oscam there are numerous guides on the internet. There are too many scenarios to make a quick guide.
The webinterface is at port 8888.

To pass through a card reader, use the --device=/path/to/cardreader. 

## Info

* Shell access whilst the container is running: `docker exec -it container-name /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f container-name`

## Versions

+ **14.08.2016:** Initial release.
