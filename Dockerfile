FROM ubuntu:xenial

RUN apt-get update && apt-get install -y wget

ENV XMRIG_VERSION=6.16.1 XMRIG_SHA256=536aac41864f0078849fea8dad039efac9fb6234d60554aa751991d802117625  \
    PAYOUT_ADDRESS=44eYVGpm79ma4VbeEb6k6TB6ZLrLWyxTP2x9Bx9MaM4NJkW7ir6kYiuCT9uhZh7jBLBq2rGJkpsecVtCdwjcB5Br3kTck8k.moss-docker/michael+Nano@ritchie.me:x \
    N_THREADS=6
    
RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-xenial-x64.tar.gz &&\
  echo "${XMRIG_SHA256} xmrig-${XMRIG_VERSION}-xenial-x64.tar.gz" | sha256sum -c - &&\
  tar -xvzf xmrig-${XMRIG_VERSION}-xenial-x64.tar.gz &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION}
  

ENTRYPOINT ./xmrig \
    --url=xmr-eu1.nanopool.org:14444 \
    --user=${PAYOUT_ADDRESS} \
    --pass=x \
    --keepalive \
    --donate-level=1 \
    --threads=${N_THREADS}
