#!/bin/bash

set -e

DAGGER_VERSION=${VERSION:-"latest"}

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

export DEBIAN_FRONTEND=noninteractive

check_packages curl ca-certificates

echo "Installing Dagger CLI version: $DAGGER_VERSION"

if [ "${DAGGER_VERSION}" != "latest" ]; then
    curl -fsSL https://dl.dagger.io/dagger/install.sh | DAGGER_VERSION=${DAGGER_VERSION} BIN_DIR=/usr/local/bin sh
else
    curl -fsSL https://dl.dagger.io/dagger/install.sh | BIN_DIR=/usr/local/bin sh
fi

# Ensure Dagger is in PATH
echo "export PATH=\$PATH:/root/.dagger/bin" >> /etc/profile.d/dagger.sh
chmod +x /etc/profile.d/dagger.sh

echo "Done!"
