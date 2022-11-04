FROM debian:11

# Install toolchain
FROM sbtscala/scala-sbt:eclipse-temurin-18.0.1_1.6.2_2.13.8
ARG CLANG_VERSION=15
RUN apt-get update && apt-get install -y curl lsb-release wget software-properties-common gnupg git
RUN curl -fsSL https://apt.llvm.org/llvm.sh | bash -s -- -m https://apt.llvm.org $CLANG_VERSION all
RUN curl -fsSL https://gist.githubusercontent.com/howardlau1999/7ea2cffedc0491c46fa14e1f2355a9a8/raw/7886c0344e8f010a9d515a3de20983e604ae5a0a/update-alternatives-clang.sh | bash -s -- $CLANG_VERSION 100
RUN apt-get install -y verilator make cmake g++
RUN apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Clone repositories
WORKDIR /root
ADD https://api.github.com/repos/riscv-non-isa/riscv-arch-test/git/refs/tags/2.6.1 .riscv-arch-test-git-info.json
RUN git clone -b 2.6.1 --depth 1 https://github.com/riscv-non-isa/riscv-arch-test
ADD https://api.github.com/repos/howardlau1999/yatcpu/git/refs/heads/main .yatcpu-git-info.json
RUN git clone --depth 1 https://github.com/howardlau1999/yatcpu

# Let sbt download necessary packages
RUN cd yatcpu && sbt update
RUN cd yatcpu && sbt compile
ENTRYPOINT [ "/bin/bash" ]