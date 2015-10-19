# docker-tunnel

## Introduction

A simple docker image to enable an easy but dirty tunnel mounting

## Usage

```
docker run -d \
    --net=host \
    -e GATEWAY_HOST="my.gateway.host" \
    -e GATEWAY_USER="user" \
    -e GATEWAY_PWD="password" \
    -e TUNNEL_LOCAL_PORT="local_port" \
    -e TUNNEL_REMOTE_HOST="my.remote.host" \
    -e TUNNEL_REMOTE_PORT="remote_port" \
    tunnel
```

## Documentation and references

* [Disable ssh host check](http://linuxcommando.blogspot.fr/2008/10/how-to-disable-ssh-host-key-checking.html)
* [Man ssh](http://www.delafond.org/traducmanfr/man/man1/ssh.1.html)
* [SSH password auth in scripts](http://stackoverflow.com/questions/12118308/command-line-to-execute-ssh-with-password-authentication)
* [SSH tunnel](http://www.revsys.com/writings/quicktips/ssh-tunnel.html)
* [SSH tunnel and docker](https://intercityup.com/blog/how-to-expose-an-ssh-tunnel-to-localhost-in-a-docker-container-via-vagrant.html)

## TODO

Trap better docker stop signals.
