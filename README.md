# Docker image with LXQt Desktop over headless VNC environments
### Centos is replaced by Fedora after [this news](https://blog.centos.org/2020/12/future-is-centos-stream/).

This repository contains a Docker image with minimal Desktop installation and includes: Fedora minimal + OpenBox + LXQt + TigerVNC-Server.

The Image is automatically rebuilt every day, at midnight by GMT.

All other software you can install yourself.

![Docker LXQt Desktop access via TightVNC Client](https://raw.githubusercontent.com/LabEG/centos-lxqt-vnc/master/.pics/vnc_container_view.jpg)


### Try
If you just want to try the features:
```sh
docker run -it --rm -e password='YOUR_VNC_PASSWORD' -p 5901:5901 labeg/centos-lxqt-vnc
```

### Use
If you want to use the container regularly:
```sh
docker run -d --restart always -e password='YOUR_VNC_PASSWORD' -p 5901:5901 labeg/centos-lxqt-vnc
```

### Parameters
- `-e password='YOUR_VNC_PASSWORD'` - required, password for VNC connections.
- `-e user_password='YOUR_USER_PASSWORD'` - optional, password for user *headless*. By default, will be used *password* variable.
- `-e root_password='YOUR_ROOT_PASSWORD'` - optional, password for *root* user. By default, will be used *user_password* variable, if it is not specified then *password* variable.
- `-e resolution='1920x1080'` - optional, resolution for virtual screen.
- `--shm-size='64m'` - optional, extend if firefox browser is crashing.

### FAQ
- For change LXQT Theme open Menu > Preferences > Appearance > LXQt Theme and select nice to you theme, example Kde-Plasma.
- For change OpenBox theme open Menu > Preferences > LXQt settings > Opebox Settings and select nice to you theme, example Clearlooks.


### Build

```sh
docker build -t labeg/centos-lxqt-vnc .
```
