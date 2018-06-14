FROM alpine:3.7 AS build
#
# Copyright (c) 2018 Cryply developers
# Distributed under the MIT/X11 software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
LABEL maintainer "Balloo <flint@kraflink.com>"

WORKDIR /src

RUN apk add --no-cache \
      alpine-sdk autoconf libtool automake boost-dev openssl-dev db-dev git \
      git clone https://github.com/cryply/cryply-wallet.git cryply \
      && cd cryply            \
      && ./autogen.sh         \
      && ./configure          \
      --enable-upnp-default   \
      --without-gui           \
      --disable-tests         \
      --with-incompatible-bdb \
      && make -j$(nproc)      \
      && make install

FROM alpine:3.7

COPY --from=build /usr/local/bin/cryplyd    /usr/local/bin/cryplyd
COPY --from=build /usr/local/bin/cryply-cli /usr/local/bin/cryply-cli

RUN apk add --no-cache db-c++ boost boost-program_options openssl

ADD ./entrypoint.sh /

WORKDIR /data

VOLUME ["/data"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["cryplyd"]
