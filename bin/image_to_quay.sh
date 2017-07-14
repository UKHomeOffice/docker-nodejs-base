#!/bin/sh

#get node version from dockerfile
NODE_VERSION=$(grep "ENV NODE_VERSION" Dockerfile | sed 's/^ENV NODE_VERSION v//');

#get major, minor and patch
MAJOR=`echo $NODE_VERSION | awk '{split($0,a,"."); print a[1]}'`;
MINOR=`echo $NODE_VERSION | awk '{split($0,a,"."); print a[2]}'`;
PATCH=`echo $NODE_VERSION | awk '{split($0,a,"."); print a[3]}'`;

docker login -u="ukhomeofficedigital+drone" -p=${DOCKER_PASSWORD} quay.io;

#major, minor patch version
echo "Publishing v${MAJOR}.${MINOR}.${PATCH} of nodejs-base...";
docker tag nodejs-base quay.io/ukhomeofficedigital/nodejs-base:v${MAJOR}.${MINOR}.${PATCH}
docker push quay.io/ukhomeofficedigital/nodejs-base:v${MAJOR}.${MINOR}.${PATCH}
echo "published v${MAJOR}.${MINOR}.${PATCH}";

#major, minor version
echo "Publishing v${MAJOR}.${MINOR} of nodejs-base";
docker tag nodejs-base quay.io/ukhomeofficedigital/nodejs-base:v${MAJOR}.${MINOR}
docker push quay.io/ukhomeofficedigital/nodejs-base:v${MAJOR}.${MINOR}
echo "published v${MAJOR}.${MINOR}";

#major
echo "Publishing v${MAJOR} of nodejs-base";
docker tag nodejs-base quay.io/ukhomeofficedigital/nodejs-base:v${MAJOR};
docker push quay.io/ukhomeofficedigital/nodejs-base:v${MAJOR};
echo "published v${MAJOR}";
