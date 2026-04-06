#!/bin/bash
set -e

# ══════════════════════════════════════════════════════════════
#  WARP Manager v2.3 — Установка на сервер
#  Cloudflare WARP · 3X-UI + AmneziaWG · Telegram Bot
# ══════════════════════════════════════════════════════════════

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

GITHUB_RAW="https://raw.githubusercontent.com/h4rd1ns0mn14/WARP-3X/main"
INSTALL_DIR="/etc/warp-manager"
BIN_PATH="/usr/local/bin/warp-manager"

echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}  WARP Manager v2.3 — Установка${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Проверка root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[ERROR] Запустите от root!${NC}"
    exit 1
fi

# Проверка ОС
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_ID="$ID"
        OS_VERSION="$VERSION_ID"
    else
        OS_ID="unknown"
    fi
}

detect_os

if [[ "$OS_ID" != "ubuntu" && "$OS_ID" != "debian" ]]; then
    echo -e "${YELLOW}[WARN] Поддерживаются только Ubuntu/Debian. Ваша: ${OS_ID}${NC}"
    echo -e "${YELLOW}  Попытка установки всё равно...${NC}"
fi

# Зависимости
echo -e "${YELLOW}[1/5]${NC} Проверка зависимостей..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y > /dev/null 2>&1
for pkg in curl jq wget; do
    if ! command -v "$pkg" &>/dev/null; then
        echo -e "  ${YELLOW}Установка ${pkg}...${NC}"
        apt-get install -y "$pkg" > /dev/null 2>&1
    fi
done
echo -e "${GREEN}  ✓ Зависимости установлены${NC}"

# Создание директории
echo -e "${YELLOW}[2/5]${NC} Создание директории..."
mkdir -p "$INSTALL_DIR"
echo -e "${GREEN}  ✓ ${INSTALL_DIR}${NC}"

# Скачивание скрипта
echo -e "${YELLOW}[3/5]${NC} Загрузка WARP Manager..."
wget -qO "$BIN_PATH" "${GITHUB_RAW}/gowarp" || curl -fsSL -o "$BIN_PATH" "${GITHUB_RAW}/gowarp"
chmod +x "$BIN_PATH"
echo -e "${GREEN}  ✓ Установлен в ${BIN_PATH}${NC}"

# Символическая ссылка
echo -e "${YELLOW}[4/5]${NC} Создание ссылки warp..."
ln -sf "$BIN_PATH" /usr/local/bin/warp 2>/dev/null || true
echo -e "${GREEN}  ✓ Команда 'warp' доступна${NC}"

# Проверка
echo -e "${YELLOW}[5/5]${NC} Проверка установки..."
if [ -f "$BIN_PATH" ] && [ -x "$BIN_PATH" ]; then
    echo -e "${GREEN}  ✓ WARP Manager готов к работе${NC}"
else
    echo -e "${RED}  ✗ Ошибка установки!${NC}"
    exit 1
fi

echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  ✓ Установка завершена!${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
echo -e "${WHITE}Запуск:${NC} ${GREEN}warp${NC} или ${GREEN}warp-manager${NC}\n"
echo -e "${WHITE}Проверка версии:${NC} ${GREEN}warp --version${NC}\n"
