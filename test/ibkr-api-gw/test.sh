#!/bin/bash

set -e

source dev-container-features-test-lib

check "gateway run.sh is installed and executable" \
  test -x /opt/ibkr/api-gw/bin/run.sh

check "java is available" \
  java -version

reportResults
