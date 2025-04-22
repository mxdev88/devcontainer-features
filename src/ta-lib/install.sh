#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Function to fetch if the latest version is available
fetch_latest_version() {
    curl -s https://api.github.com/repos/TA-Lib/ta-lib/tags | \
        jq -r '.[0].name' | sed 's/^v//'
}

echo "Installing dependencies..."
check_packages wget build-essential curl jq ca-certificates

TALIB_VERSION="${VERSION:-latest}"
echo "TA-Lib version: ${TALIB_VERSION}"
if [[ "${TALIB_VERSION}" == "latest" ]]; then
    echo "Fetching latest TA-Lib version from GitHub..."
    TALIB_VERSION="$(fetch_latest_version)"
    echo "Latest TA-Lib version: ${TALIB_VERSION}"
fi

TALIB_URL="https://github.com/TA-Lib/ta-lib/releases/download/v$TALIB_VERSION/ta-lib-$TALIB_VERSION-src.tar.gz"
echo "Downloading and extracting TA-Lib from ${TALIB_URL}..."
wget "$TALIB_URL" -O "/tmp/ta-lib-${TALIB_VERSION}.tar.gz"
cd /tmp && tar -xvzf "ta-lib-${TALIB_VERSION}.tar.gz"

echo "Building and installing TA-Lib..."
cd "ta-lib-${TALIB_VERSION}"
./configure --prefix=/usr
make && make install && ldconfig

echo "Cleaning up..."
rm -rf "/tmp/${TALIB_VERSION}" "/tmp/ta-lib-${TALIB_VERSION}.tar.gz"

echo "TA-Lib ${TALIB_VERSION} installation complete."
