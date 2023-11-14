#!/usr/bin/env bash
docker build ./ -f Dockerfile-ubuntu20.04 -t make_openwrt:v1.0
#docker build ./ -f Dockerfile -t make_openwrt:v1.0
#docker save make_openwrt:v1.0 >make_openwrt_v1.0.tar
