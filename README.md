# Docker image with LXQt Desktop over headless VNC environments

This repository contains a Docker image with minimal Desktop installation and includes: CentOS minimal + OpenBox + LXQt + TigerVNC-Server.

The Image is automatically rebuilt every day, at midnight by GMT.

All other software you can install yourself.

![Docker LXQt Desktop access via TightVNC Client](https://raw.githubusercontent.com/LabEG/centos-lxqt-vnc/master/.pics/vnc_container_view.jpg)


### Try
If you just want to try the features:
```sh
docker run -it --rm -e password='YOUR_VNC_PASSWORD' -p5901:5901 labeg/centos-lxqt-vnc
```

### Use
If you want to use the container regularly:
```sh
docker run -d --restart always -e password='YOUR_VNC_PASSWORD' -p5901:5901 labeg/centos-lxqt-vnc
```

### Parameters
- `-e password='YOUR_VNC_PASSWORD'` - password for VNC connections.
- `-e resolution='1920x1080'` - resolution for virtual screen.
- `--shm-size='64m'` - extend if firefox browser is crashing.

### FAQ
- Defaul root and user password is 'centos'. Change it on first vnc connection for more security.
- For change LXQT Theme open Menu > Preferences > Appearance > LXQt Theme and select nice to you theme, example Kde-Plasma.
- For change OpenBox theme open Menu > Preferences > LXQt settings > Opebox Settings and select nice to you theme, example Clearlooks.


### Build

```sh
docker build -t labeg/centos-lxqt-vnc .
```
