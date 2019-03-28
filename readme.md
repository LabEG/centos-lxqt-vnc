

docker build -t labeg/centos-lxqt-vnc .

docker run -e password="lxpass" -it --rm -p5901:5901 labeg/centos-lxqt-vnc
