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

RUN curl https://github.com/frappe/bench/archive/4.1.tar.gz -Lo /opt/bench-4.1.tar.gz && \
    cd /opt/ && \
    tar -zxf bench-4.1.tar.gz && \
    pip install -e /opt/bench-4.1

RUN npm config set registry https://registry.npm.taobao.org/

RUN mkdir -p /opt/apps/frappe
WORKDIR /opt/apps/frappe

