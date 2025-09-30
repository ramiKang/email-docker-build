#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y sudo curl wget vim git bash software-properties-common
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
