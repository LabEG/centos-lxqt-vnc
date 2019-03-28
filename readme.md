

docker build -t labeg/centos-lxqt-vnc .

docker run -e password="YOUR_VNC_PASSWORD" -it --rm -p5901:5901 labeg/centos-lxqt-vnc
