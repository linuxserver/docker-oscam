[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/index.php/irc/
[podcasturl]: https://www.linuxserver.io/index.php/category/podcast/

[![linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/oscam
[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/oscam.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/oscam.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-oscam)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-oscam/)
[hub]: https://hub.docker.com/r/linuxserver/oscam/

[Oscam][oscamurl] is an Open Source Conditional Access Module software used for descrambling DVB transmissions using smart cards. It's both a server and a client.

[![oscam](http://download.oscam.cc/images/Logo.png)][oscamurl]
[oscamurl]: http://www.streamboard.tv/oscam/

## Usage

```
docker create \
  --name=oscam \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8888:8888 \
  linuxserver/oscam
```

**Parameters**

* `-p 8888` - the port(s)
* `-v /config` - where oscam should store config files and logs
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

`If you pass through a card reader, add the --device=/path/to/cardreader tag.`

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it oscam /bin/bash`.

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

* Shell access whilst the container is running: `docker exec -it oscam /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f oscam`

## Versions

+ **25.09.2016:** Initial release.
