FROM debian:jessie

COPY cn.list /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y curl telnet vim locales-all \
        python python-dev python-pip git

RUN pip install -U pip virtualenv

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

RUN cd /opt/ && \
    git clone https://github.com/gshmu/bench.git && \
    pip install -e /opt/bench

RUN npm config set registry https://registry.npm.taobao.org/

RUN { \
        echo "mariadb-server-10.0" mysql-server/root_password password "toor"; \
        echo "mariadb-server-10.0" mysql-server/root_password_again password "toor"; \
    } | debconf-set-selections \
    && apt-get update \
    && apt-get install -y mariadb-server redis-server mysqlclient-dev

RUN mkdir -p /opt/apps/frappe && \
    useradd -ms /bin/bash wguser && \
    chown wguser:wguser /opt/apps/

WORKDIR /opt/apps

