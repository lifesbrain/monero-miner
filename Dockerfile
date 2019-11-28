FROM ubuntu:xenial

RUN apt-get update && apt-get install -y wget

ENV XMRIG_VERSION=5.0.1 XMRIG_SHA256=aa34890738a3494de2fa0e44db346937fea7339852f5f10b5d4655f95e2d8f1f \
    PAYOUT_ADDRESS=48gkVcVqPH3gMuRQyYWPfwQUaLiQHKyLYeM3DU8yAkkaYqqzVhZQPVGGYpyUfXqCaMM5bwNY8MuiGbzR98mkwakRLX5VDYY \
    N_THREADS=10
    
RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-xenial-x64.tar.gz &&\
  tar -xvzf xmrig-${XMRIG_VERSION}-xenial-x64.tar.gz &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION} &&\
  echo "${XMRIG_SHA256}  xmrig" | sha256sum -c -

ENTRYPOINT ./xmrig \
    --url=xmrpool.eu:3333 \
    --user=${PAYOUT_ADDRESS} \
    --pass=x \
    --keepalive \
    --threads=${N_THREADS}
