# Docker image with LXQt Desktop over headless VNC environments

This repository contains a Docker image with minimal Desktop installation and includes: CentOS minimal + OpenBox + LXQt + TigerVNC-Server.

All other soft and settings are performed manualy by you self. Example on following image showing LXQt with a modified theme to Kde-Plasma and installed Chromium, VSCode, Monodevelop (linux build of VisualStudio for Mac).

![Docker LXQt Desktop access via TightVNC Client](https://raw.githubusercontent.com/LabEG/centos-lxqt-vnc/master/.pics/vnc_container_view.png)


### Try
If you just want to try the features:
```sh
docker run -e password='YOUR_VNC_PASSWORD' -it --rm -p5901:5901 labeg/centos-lxqt-vnc
```

### Use
If you want to use the container regularly:
```sh
docker run -d --restart always -e password='YOUR_VNC_PASSWORD' -p5901:5901 labeg/centos-lxqt-vnc
```

### FAQ
- Defaul root and user password is 'centos'. Change it on first vnc connection for more security.
- For change LXQT Theme open Menu > Preferences > Appearance > LXQt Theme and select nice to you theme, example Kde-Plasma.
- For change OpenBox theme open Menu > Preferences > LXQt settings > Opnbox Settings and select nice to you theme, example Clearlooks.


### Build
```sh
docker build -t labeg/centos-lxqt-vnc .
```