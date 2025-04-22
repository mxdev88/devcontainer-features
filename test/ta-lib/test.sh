#!/bin/bash

set -e

source dev-container-features-test-lib

check "TA-Lib C Library" ldconfig -p | grep -q 'libta-lib.so'
check "TA-Lib header file" test -f /usr/include/ta-lib/ta_libc.h

reportResults
