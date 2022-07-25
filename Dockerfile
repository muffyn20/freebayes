# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y \
  g++ \
  bc \
  samtools \
  parallel \
  meson \
  ninja-build \
  libvcflib-tools \
  vcftools \
  git

# build
COPY . /src
WORKDIR /src
RUN git submodule update --init --recursive --progress
RUN meson build/ && ninja -C build/ && ninja -C build/ install
