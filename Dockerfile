
FROM fedora:latest


LABEL maintainer="labeg@mail.ru" \
      io.k8s.description="Headless VNC Container with LXQt Desktop manager" \
      io.k8s.display-name="Headless VNC Container based on Centos" \
      io.openshift.expose-services="5901:xvnc" \
      io.openshift.tags="vnc, centos, lxqt" \
      io.openshift.non-scalable=true


ENV HOME=/home/headless


RUN dnf install -y \
            tigervnc-server \
            openbox obconf-qt \
            lxqt-about lxqt-common lxqt-config lxqt-globalkeys lxqt-notificationd \
            lxqt-openssh-askpass lxqt-panel lxqt-policykit lxqt-qtplugin lxqt-runner \
            lxqt-session pcmanfm-qt \
            dejavu-sans-mono-fonts \
            xterm nano htop expect sudo \
            passwd binutils wget \
        && \
        strip --remove-section=.note.ABI-tag /usr/lib64/libQt5Core.so.5 \
        && \
        dnf clean all \
        && \
        rm -rf /var/cache/dnf/*
# 202MB -> 648MB


RUN /bin/dbus-uuidgen --ensure && \
        useradd headless && \
        echo "centos" | passwd --stdin root && \
        echo "centos" | passwd --stdin headless && \
        usermod -aG wheel headless


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


# apply plazma theme, wallpaper, qterimal and pcman to quicklaunch
RUN mkdir -p ${HOME}/.config/lxqt && \
        echo '[General]' >> ${HOME}/.config/lxqt/lxqt.conf && \
        echo 'theme=kde-plasma' >> ${HOME}/.config/lxqt/lxqt.conf \
        && \
        mkdir -p ${HOME}/.config/pcmanfm-qt/lxqt && \
        echo '[Desktop]' >> ${HOME}/.config/pcmanfm-qt/lxqt/settings.conf && \
        echo 'Wallpaper=/usr/share/lxqt/themes/kde-plasma/kde-plasma.png' >> ${HOME}/.config/pcmanfm-qt/lxqt/settings.conf && \
        echo 'WallpaperMode=stretch' >> ${HOME}/.config/pcmanfm-qt/lxqt/settings.conf \
        && \
        mkdir -p ${HOME}/.config/lxqt/ && \
        echo '[quicklaunch]' >> ${HOME}/.config/lxqt/panel.conf && \
        echo 'apps\1\desktop=/usr/share/applications/qterminal.desktop' >> ${HOME}/.config/lxqt/panel.conf && \
        echo 'apps\2\desktop=/usr/share/applications/pcmanfm-qt.desktop' >> ${HOME}/.config/lxqt/panel.conf && \
        echo 'apps\size=3' >> ${HOME}/.config/lxqt/panel.conf


ENTRYPOINT ["expect", "./startup.sh"]
