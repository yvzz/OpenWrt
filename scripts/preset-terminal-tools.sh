#!/bin/bash
# Configure TTYD terminal without login
set -e

OPENWRT_PATH="${OPENWRT_PATH:-$PWD}"
TTYD_CONFIG="${OPENWRT_PATH}/package/feeds/packages/ttyd/files/ttyd.config"

if [ -f "$TTYD_CONFIG" ]; then
    echo "Configuring ttyd for no-login mode..."
    sed -i 's/config ttyd\t\ttyd/config ttyd/' "$TTYD_CONFIG"
    sed -i 's/option command/#option command/' "$TTYD_CONFIG"
    echo "ttyd configured successfully"
else
    echo "ttyd config not found, skipping"
fi
