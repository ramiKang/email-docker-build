#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y --no-install-recommends $(sed -e '/^\s*#.*$/d' -e '/^\s*$/d' "$1" | sort -u)

apt-get clean
rm -rf /var/lib/apt/lists/*
