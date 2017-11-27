# usage: docker run brianpugh/monero-miner -a cryptonight -u user -p password
# ex: docker run brianpugh/monero-miner -a cryptonight -o stratum+tcp://mine.moneropool.com:3333 -u 4AsZFFoMcNQF6sBWQL9zT3AmUkxGtcrGTKePCcamDZ9kBMZPEbPoTaT6TTnnY988HPJi3uybVtkWcHwixuAydwdD8MsqsWU -p x --threads 2
FROM		ubuntu:latest

ENV PAYOUT_ADDRESS=48gkVcVqPH3gMuRQyYWPfwQUaLiQHKyLYeM3DU8yAkkaYqqzVhZQPVGGYpyUfXqCaMM5bwNY8MuiGbzR98mkwakRLX5VDYY \
    N_THREADS=6
    
RUN		apt-get update -qq && apt-get install -qqy \
  automake \
  libcurl4-openssl-dev \
  git \
  make \
  build-essential

RUN		git clone https://github.com/wolf9466/cpuminer-multi

RUN		cd cpuminer-multi && ./autogen.sh && ./configure CFLAGS="-O3" && make

WORKDIR		/cpuminer-multi

ENTRYPOINT ./minerd -a cryptonight -o stratum+tcp://mine.moneropool.com:3333 \
    -u ${PAYOUT_ADDRESS} \
    -p x \
    --threads ${N_THREADS}
