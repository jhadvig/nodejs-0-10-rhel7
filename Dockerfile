FROM rhel7

RUN yum update -y && \
    yum install -y yum-utils wget tar gettext tar which gcc-c++ automake autoconf curl-devel \
    openssl-devel zlib-devel libxslt-devel libxml2-devel \
    mysql-libs mysql-devel postgresql-devel sqlite-devel && \
    yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    yum install -y --setopt=tsflags=nodocs nodejs010 && \
    yum clean all -y


ADD ./nodejs         /opt/nodejs/
ADD ./.sti/bin/usage /opt/nodejs/bin/


ENV STI_SCRIPTS_URL https://raw.githubusercontent.com/jhadvig/nodejs-0-10-rhel7/master/.sti/bin


ENV STI_LOCATION /tmp


RUN mkdir -p /opt/nodejs/{run,src} && \
    groupadd -r nodejs -f -g 433 && \
    useradd -u 431 -r -g nodejs -d /opt/nodejs -s /sbin/nologin -c "NodeJS user" nodejs && \
    chown -R nodejs:nodejs /opt/nodejs && \
    mv -f /opt/nodejs/bin/nodejs /usr/bin/nodejs


ENV APP_ROOT .
ENV HOME     /opt/nodejs
ENV PATH     $HOME/bin:$PATH


WORKDIR     /opt/nodejs/src

USER nodejs


EXPOSE 3000

CMD ["/opt/nodejs/bin/usage"]