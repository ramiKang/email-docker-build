#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

wget https://developer.download.nvidia.com/compute/cudnn/redist/cudnn/linux-x86_64/cudnn-linux-x86_64-9.3.0.75_cuda12-archive.tar.xz
tar -xvf cudnn-linux-x86_64-9.3.0.75_cuda12-archive.tar.xz
cp cudnn-linux-x86_64-9.3.0.75_cuda12-archive/include/cudnn*.h /usr/local/cuda-12.5/include
cp cudnn-linux-x86_64-9.3.0.75_cuda12-archive/lib/libcudnn* /usr/local/cuda-12.5/lib64
