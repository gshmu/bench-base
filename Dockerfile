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
    git clone https://github.com/frappe/bench.git && \
    pip install -e /opt/bench

RUN npm config set registry https://registry.npm.taobao.org/

RUN mkdir -p /opt/apps/frappe
WORKDIR /opt/apps/frappe

