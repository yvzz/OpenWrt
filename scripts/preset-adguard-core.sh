#!/bin/bash
# Download AdGuardHome core
set -e

OPENWRT_PATH="${OPENWRT_PATH:-$PWD}"
CLASH_KERNEL="${CLASH_KERNEL:-amd64}"

# Map architecture
case "$CLASH_KERNEL" in
    amd64) ARCH="x86_64" ;;
    arm64) ARCH="arm64" ;;
    arm)   ARCH="armv7" ;;
    *)     ARCH="$CLASH_KERNEL" ;;
esac

ADGUARD_VER="v0.107.52"
ADGUARD_URL="https://github.com/AdguardTeam/AdGuardHome/releases/download/${ADGUARD_VER}/AdGuardHome_linux_${ARCH}.tar.gz"
ADGUARD_PATH="${OPENWRT_PATH}/package/luci-app-adguardhome/files"

mkdir -p "${ADGUARD_PATH}"
echo "Downloading AdGuardHome core from ${ADGUARD_URL}..."
wget -qO- "${ADGUARD_URL}" | tar xzf - -C "${ADGUARD_PATH}" AdGuardHome/AdGuardHome --strip-components=1 || {
    echo "Failed to download AdGuardHome core"
    exit 1
}
chmod +x "${ADGUARD_PATH}/AdGuardHome"
echo "AdGuardHome core downloaded successfully"
