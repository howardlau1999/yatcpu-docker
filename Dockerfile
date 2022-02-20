FROM debian:11
RUN apt update && apt install -y scala gnupg curl git perl python3 make autoconf clang clang++ llvm cmake flex bison libgoogle-perftools-dev numactl perl-doc
WORKDIR /usr/src/
RUN git clone --depth 1 -b stable https://github.com/verilator/verilator && cd verilator && autoconf && autoupdate && ./configure && make -j `nproc` && make install && rm -rf /usr/src/verilator
RUN curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --dearmor -o /usr/share/keyrings/scalasbt-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/scalasbt-archive-keyring.gpg] https://repo.scala-sbt.org/scalasbt/debian all main" > /etc/apt/sources.list.d/sbt.list
RUN apt update && apt install -y sbt
WORKDIR /root
ADD https://api.github.com/repos/howardlau1999/yatcpu/git/refs/heads/main .yatcpu-git-info.json
RUN git clone --depth 1 https://github.com/howardlau1999/yatcpu
WORKDIR /root/yatcpu
RUN sbt update
RUN sbt compile
ENTRYPOINT [ "/bin/bash" ]