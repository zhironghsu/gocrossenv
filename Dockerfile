FROM golang:1.23.4-bullseye
LABEL os=linux
LABEL arch=amd64

# install build & runtime dependencies
RUN dpkg --add-architecture arm64 \
 && dpkg --add-architecture amd64 \
 && dpkg --add-architecture arm64 \
 && dpkg --add-architecture armhf \
 && dpkg --add-architecture armel \
 && dpkg --add-architecture i386 \
 && apt update \
 && apt install -y --no-install-recommends \
        upx \
        pkg-config \
        mingw-w64 \
        build-essential \
        crossbuild-essential-arm64 \
        crossbuild-essential-armhf \
        crossbuild-essential-armel \
        crossbuild-essential-i386 \
        libpam0g:amd64 \
        libpam0g-dev:amd64 \
        libpam0g:arm64 \
        libpam0g-dev:arm64 \
        libpam0g:armhf \
        libpam0g-dev:armhf \
        libpam0g:i386 \
        libpam0g-dev:i386 \
        libpam0g:armel \
        libpam0g-dev:armel \
 && apt -y autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    rm -rf /usr/share/man/* \
    /usr/share/doc

# install build dependencies (code generators)
RUN set -ex \
    && GOOS=linux GOARCH=amd64 go install github.com/josephspurrier/goversioninfo/cmd/goversioninfo@v1.4.0
