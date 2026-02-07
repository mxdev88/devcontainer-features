#!/usr/bin/env bash
set -e

INSTALL_DIR="${INSTALLDIR:-/opt/ibkr/api-gw}"
TMP_DIR="/tmp/ibkr-api-gw"
GATEWAY_URL="https://download2.interactivebrokers.com/portal/clientportal.gw.zip"

apt_get_update() {
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

check_packages curl unzip ca-certificates

echo "Installing IBKR Client Portal API Gateway..."
echo "Install directory: ${INSTALL_DIR}"

mkdir -p "${INSTALL_DIR}"
mkdir -p "${TMP_DIR}"

echo "Downloading Client Portal Gateway..."
curl -fsSL "${GATEWAY_URL}" -o "${TMP_DIR}/clientportal.gw.zip"

echo "Extracting Gateway..."
unzip -q "${TMP_DIR}/clientportal.gw.zip" -d "${INSTALL_DIR}"

chmod +x "${INSTALL_DIR}/bin/run.sh"

rm -rf "${TMP_DIR}"

echo
echo "IBKR Client Portal API Gateway installed successfully."
echo "Location: ${INSTALL_DIR}"
echo
echo "To start the Gateway:"
echo "  cd ${INSTALL_DIR}"
echo "  ./bin/run.sh"
