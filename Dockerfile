FROM ubuntu:16.04
MAINTAINER Perry Evans <https://github.com/samesense>

RUN apt-get update -qqq \
&& apt-get install -y wget curl git r-base-core libssl1.0.0 libssl-dev libcurl4-openssl-dev pkg-config

RUN git clone https://github.com/Danko-Lab/dREG \
&& cd dREG \
&& make R_dependencies \
&& make dreg

RUN wget https://github.com/Danko-Lab/dREG-Model/blob/master/asvm.mammal.RData\?raw\=true -O /lib/asvm.mammal.RData

RUN apt-get autoremove -y \
&& apt-get remove --purge -y git

ENV PATH dREG/:$PATH
