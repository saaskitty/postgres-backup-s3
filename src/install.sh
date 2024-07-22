#! /bin/sh

set -eux
set -o pipefail

apk add build-base gcc postgresql-dev bison flex perl readline-dev zlib-dev
apk update

# install pg_dump
wget https://ftp.postgresql.org/pub/source/v17beta2/postgresql-${POSTGRES_VERSION}.tar.gz
tar -xvzf postgresql-${POSTGRES_VERSION}.tar.gz
cd postgresql-${POSTGRES_VERSION}
./configure
make
make install

# install gpg
apk add gnupg
apk add aws-cli

# install go-cron
apk add curl
curl -L https://github.com/ivoronin/go-cron/releases/download/v0.0.5/go-cron_0.0.5_linux_${TARGETARCH}.tar.gz -O
tar xvf go-cron_0.0.5_linux_${TARGETARCH}.tar.gz
rm go-cron_0.0.5_linux_${TARGETARCH}.tar.gz
mv go-cron /usr/local/bin/go-cron
chmod u+x /usr/local/bin/go-cron
apk del curl

# cleanup
rm -rf /var/cache/apk/*
