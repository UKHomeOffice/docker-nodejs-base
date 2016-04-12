FROM quay.io/ukhomeofficedigital/centos-base

RUN groupadd -r nodejs && \
    useradd -r -g nodejs nodejs -d app

RUN mkdir -p /opt/nodejs /app && \
    chown -R nodejs:nodejs /app

WORKDIR /opt/nodejs
ENV NODE_VERSION v4.4.2
RUN yum install -y curl && \
    curl https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1

ENV PATH=${PATH}:/opt/nodejs/bin
WORKDIR /app
