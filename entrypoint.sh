#!/usr/bin/env bash

if [[ "start test run" =~ $1 ]]; then
    CMD=( $( which npm ) )
    CMD+=( "${@:1}" )
else
    CMD=( "$@" )
fi

exec ${CMD[*]}
