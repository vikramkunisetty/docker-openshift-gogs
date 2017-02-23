FROM centos:7

MAINTAINER Wolfgang Kulhanek <WolfgangKulhanek@gmail.com>

ENV GOGS_VERSION="0.9.141"

LABEL name="Gogs - Go Git Service" \
      vendor="Gogs" \
      io.k8s.display-name="Gogs - Go Git Service" \
      io.k8s.description="The goal of this project is to make the easiest, fastest, and most painless way of setting up a self-hosted Git service." \
      summary="The goal of this project is to make the easiest, fastest, and most painless way of setting up a self-hosted Git service." \
      io.openshift.expose-services="3000,gogs" \
      io.openshift.tags="gogs" \
      build-date="2017-02-23" \
      version="0.9.141" \
      release="1"

ENV HOME=/var/lib/gogs

COPY ./root /

RUN rpm --import https://rpm.packager.io/key && \
    yum -y install epel-release && \
    yum -y --setopt=tsflags=nodocs install gogs nss_wrapper gettext && \
    yum -y clean all && \
    mkdir -p /var/lib/gogs

RUN /usr/bin/fix-permissions /var/lib/gogs && \
    /usr/bin/fix-permissions /home/gogs && \
    /usr/bin/fix-permissions /opt/gogs && \
    /usr/bin/fix-permissions /etc/gogs && \
    /usr/bin/fix-permissions /var/log/gogs

VOLUME /home/gogs/gogs-repositories
VOLUME /data

EXPOSE 3000
USER 997

CMD ["/usr/bin/rungogs"]
