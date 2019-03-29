# Docker image with headless VNC environments

This repository contains a Docker image with headless VNC environments.


![Docker VNC Desktop access via TightVNC Client](.pics/vnc_container_view.png)


### Try
If you just want to try the features:
```sh
docker run -e password="YOUR_VNC_PASSWORD" -it --rm -p5901:5901 labeg/centos-lxqt-vnc
```

### Use
If you want to use the container regularly:
```sh
docker run -d -e password="YOUR_VNC_PASSWORD" -p5901:5901 --restart always labeg/centos-lxqt-vnc
```

### For setup root and users password
For use root user, you must set a password. To do this, run the command:
```sh
docker exec -u 0 -it CONTAINER_ID bash
```

Enter 'passwd root' and set password.

### Build
```sh
docker build -t labeg/centos-lxqt-vnc .
```