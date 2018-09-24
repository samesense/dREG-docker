FROM ubuntu:18.04
MAINTAINER Perry Evans <https://github.com/samesense>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qqq \
&& apt-get install -y dialog apt-utils wget curl git r-base-core libssl1.0.0 libssl-dev libcurl4-openssl-dev pkg-config bzip2 tar build-essential libc6-dev

RUN git clone https://github.com/Danko-Lab/dREG \
&& cd dREG \
&& make R_dependencies \
&& make dreg

RUN wget https://github.com/Danko-Lab/dREG-Model/blob/master/asvm.mammal.RData\?raw\=true -O /lib/asvm.mammal.RData

RUN cd ..
RUN git clone https://github.com/bedops/bedops.git
RUN cd bedops && make && make install && cp bin/* /usr/local/bin

RUN apt-get autoremove -y \
&& apt-get remove --purge -y git

ENV PATH dREG/:$PATH:/usr/local/bin
