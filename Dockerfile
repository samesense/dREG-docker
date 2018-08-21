FROM phusion/baseimage
MAINTAINER Perry Evans <https://github.com/samesense>

RUN apt-get update -qqq \
&& apt-get install -y wget curl git r-base-core libssl1.0.0 libssl-dev

RUN git clone https://github.com/Danko-Lab/dREG \
&& cd dREG \
&& make R_dependencies \
&& make dreg

RUN apt-get autoremove -y \
&& apt-get remove --purge -y git

RUN rm -rf dREG
