#!/bin/bash

set -e

source dev-container-features-test-lib

# Feature-specific tests
check "version" dagger version

# Report results
reportResults