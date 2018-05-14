FROM quay.io/ukhomeofficedigital/centos-base

WORKDIR /opt/nodejs
ENV NODE_VERSION v8.11.1

RUN groupadd -r nodejs && \
    useradd -r -u 999 -g nodejs nodejs -d /app && \
    mkdir -p /opt/nodejs /app && \
    chown -R nodejs:nodejs /app && \
    yum install -y curl git && yum clean all && rpm --rebuilddb && \
    curl https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1

ENV PATH=${PATH}:/opt/nodejs/bin
WORKDIR /app

ONBUILD RUN yum clean all && \
    yum update -y -q && \
    yum clean all && \
    rpm --rebuilddb
