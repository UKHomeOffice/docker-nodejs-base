#!/bin/sh

#get node version from dockerfile
NODE_VERSION=$(grep "ENV NODE_VERSION" Dockerfile | sed 's/^ENV NODE_VERSION v//')

#get major, minor and patch
MAJOR=`echo $NODE_VERSION | awk '{split($0,a,"."); print a[1]}'`
MINOR=`echo $NODE_VERSION | awk '{split($0,a,"."); print a[2]}'`
PATCH=`echo $NODE_VERSION | awk '{split($0,a,"."); print a[3]}'`

docker login -u="ukhomeofficedigital+drone" -p="${DOCKER_PASSWORD}" quay.io

tag_n_push() {
  echo "Publishing v${1} of nodejs-base..."
  docker tag nodejs-base "quay.io/ukhomeofficedigital/nodejs-base:v${1}"
  docker push "quay.io/ukhomeofficedigital/nodejs-base:v${1}"
  echo "published v${1}"
}

#major, minor patch version
tag_n_push "${MAJOR}.${MINOR}.${PATCH}"

#major, minor version
tag_n_push "${MAJOR}.${MINOR}"

#major
tag_n_push "${MAJOR}"
