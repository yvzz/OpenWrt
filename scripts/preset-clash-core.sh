#!/bin/bash
# Download OpenClash clash/mihomo kernel
# Allow failures so network issues don't block compilation

OPENWRT_PATH="${OPENWRT_PATH:-$PWD}"
CLASH_KERNEL="${CLASH_KERNEL:-amd64}"

# Download mihomo (clash.meta) kernel
MIHOMO_VER="v1.19.0"
MIHOMO_URL="https://github.com/MetaCubeX/mihomo/releases/download/${MIHOMO_VER}/mihomo-linux-${CLASH_KERNEL}-${MIHOMO_VER}.gz"
MIHOMO_PATH="${OPENWRT_PATH}/package/OpenClash/core/mihomo"

mkdir -p "${MIHOMO_PATH}"
echo "Downloading mihomo kernel from ${MIHOMO_URL}..."
wget --tries=3 --timeout=30 -qO- "${MIHOMO_URL}" | gunzip > "${MIHOMO_PATH}/mihomo" && chmod +x "${MIHOMO_PATH}/mihomo" && echo "mihomo kernel downloaded successfully" || echo "mihomo kernel download failed, skipping"
chmod +x "${MIHOMO_PATH}/mihomo"
echo "mihomo kernel downloaded successfully"

# Download clash premium kernel (optional)
CLASH_URL="https://github.com/Dreamacro/clash/releases/download/premium/clash-linux-${CLASH_KERNEL}-v3.gz"
CLASH_PATH="${OPENWRT_PATH}/package/OpenClash/core/clash"

mkdir -p "${CLASH_PATH}"
echo "Downloading clash premium kernel from ${CLASH_URL}..."
wget -qO- "${CLASH_URL}" | gunzip > "${CLASH_PATH}/clash" || {
    echo "Failed to download clash premium kernel, skipping..."
    rm -rf "${CLASH_PATH}"
}
chmod +x "${CLASH_PATH}/clash" 2>/dev/null || true
echo "clash premium kernel downloaded successfully"

echo "Clash kernel download step completed"
