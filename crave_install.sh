#!/bin/bash

clear


GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
NC="\033[0m"


print_step() {
  echo -e "${YELLOW}[➤] $1${NC}"
}

success_msg() {
  echo -e "${GREEN}[✔] $1${NC}"
}

error_exit() {
  echo -e "${RED}[✖] Error: $1${NC}"
  exit 1
}


echo -e "${BLUE}"
echo "===================================================="
echo "       🔧 Crave Setuper - debian via Termux         "
echo "===================================================="
echo -e "${NC}"


ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then
    echo -e "${BLUE}[🔍] Detected Architecture: ${GREEN}arm64 (aarch64) — supported ✅${NC}"
else
    echo -e "${RED}[✖] Detected Architecture: $ARCH — unsupported ❌${NC}"
    echo -e "${RED}[⚠] This script supports only ARM64 (aarch64) devices.${NC}"
    exit 1
fi


print_step "Installing proot-distro..."
pkg install -y proot-distro > /dev/null 2>&1 || error_exit "Failed to install proot-distro"
success_msg "proot-distro installed."


if proot-distro list | grep -q "debian"; then
    echo -e "${YELLOW}[⚠] Existing debian container detected. Removing...${NC}"
    proot-distro remove debian > /dev/null 2>&1 || {
        echo -e "${RED}[✖] Failed to remove existing debian container.${NC}"
        exit 1
    }
    echo -e "${GREEN}[✔] Old debian container removed.${NC}"
fi

print_step "Installing debian container (this may take some time)..."
proot-distro install debian > /dev/null 2>&1 || error_exit "Failed to install debian"
success_msg "debian container installed."

print_step "Setting up Crave inside debian..."


proot-distro login debian < /dev/null 2>/dev/null << EOF

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
BLUE="\033[1;34m"
NC="\033[0m"

echo -e "\${BLUE}[📦] Updating package list...\${NC}"
apt-get update > /dev/null 2>&1

echo -e "\${YELLOW}[➤] Installing dependencies (ssh, rsync, wget, curl)...\${NC}"
apt-get install -y ssh rsync wget curl > /dev/null 2>&1 || {
  echo -e "\${RED}[✖] Failed to install dependencies.\${NC}"
  exit 1
}
echo -e "\${GREEN}[✔] Dependencies installed.\${NC}"

echo -e "\${YELLOW}[➤] Downloading Crave with progress...\${NC}"
curl -# https://raw.githubusercontent.com/accupara/crave/refs/heads/master/get_crave.sh | bash -s -- > /dev/null 2>&1 || {
  echo -e "\${RED}[✖] Failed to download Crave.\${NC}"
  exit 1
}

chmod +x crave && mv crave /usr/local/bin > /dev/null 2>&1 || {
  echo -e "\${RED}[✖] Failed to move Crave to /usr/local/bin.\${NC}"
  exit 1
}

echo -e "\${GREEN}[✔] Crave installed successfully inside debian.\${NC}"
EOF


echo -e "${GREEN}"
echo "===================================================="
echo " ✅ Crave is now installed inside your debian container!"
echo " 🔍 To use Crave:"
echo "     → Run:  proot-distro login debian"
echo "     → Then: Download crave.conf file"
echo "     → Then: type crave -n devspace and enter"
echo "===================================================="
echo -e "${NC}"

#By @Jayedkhan800
