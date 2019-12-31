
FROM centos:7


LABEL maintainer="labeg@mail.ru" \
      io.k8s.description="Headless VNC Container with LXQt Desktop manager" \
      io.k8s.display-name="Headless VNC Container based on Centos" \
      io.openshift.expose-services="5901:xvnc" \
      io.openshift.tags="vnc, centos, lxqt" \
      io.openshift.non-scalable=true


ENV HOME=/home/headless


RUN yum install -y epel-release dnf \
        && \
        dnf install -y \
            tigervnc-server \
            openbox obconf-qt \
            lxqt-about lxqt-common lxqt-config lxqt-globalkeys lxqt-notificationd \
            lxqt-openssh-askpass lxqt-panel lxqt-policykit lxqt-qtplugin lxqt-runner \
            lxqt-session pcmanfm-qt \
            dejavu-sans-mono-fonts \
            xterm nano htop expect sudo \
        && \
        yum clean all && dnf clean all \
        && \
        rm -rf /var/cache/yum/* && rm -rf /var/cache/dnf/*
# 202MB -> 648MB


RUN /bin/dbus-uuidgen --ensure && \
        useradd headless && \
        echo "centos" | passwd --stdin root && \
        echo "centos" | passwd --stdin headless


COPY ./startup.sh ${HOME}
RUN mkdir -p ${HOME}/.vnc \
        && \
        echo '#!/bin/sh' > ${HOME}/.vnc/xstartup && \
        echo 'exec startlxqt' >> ${HOME}/.vnc/xstartup && \
        chmod 775 ${HOME}/.vnc/xstartup \
        && \
        chown headless:headless -R ${HOME}


WORKDIR ${HOME}
USER headless
ENTRYPOINT ["expect", "./startup.sh"]
