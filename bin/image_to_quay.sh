#!/bin/sh

#get node version from dockerfile
PATCH=$(grep "ENV NODE_VERSION" Dockerfile | awk -F ' ' '{print $NF}')
MINOR=`echo ${PATCH} | awk -F '.' '{print $1"."$2}'`
MAJOR=`echo ${MINOR} | awk -F '.' '{print $1}'`

docker login -u="ukhomeofficedigital+drone" -p="${DOCKER_PASSWORD}" quay.io

tag_n_push() {
  echo "Publishing ${1} of nodejs-base..."
  docker tag nodejs-base "quay.io/ukhomeofficedigital/nodejs-base:${1}"
  docker push "quay.io/ukhomeofficedigital/nodejs-base:${1}"
  echo "published ${1}"
}

#major, minor patch version
tag_n_push "${PATCH}"

#major, minor version
tag_n_push "${MINOR}"

#major
tag_n_push "${MAJOR}"
