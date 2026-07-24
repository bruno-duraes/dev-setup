#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do Docker
# Descrição: Instala o Docker Engine e Docker Compose Plugin via repositório APT oficial.
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }
log_error()   { echo -e "${RED}[ERRO]${NC} $1"; }

export DEBIAN_FRONTEND=noninteractive

install_docker() {
    if command -v docker &> /dev/null; then
        log_warn "Docker já está instalado no sistema. Pulando instalação."
        return 0
    fi

    log_info "Configurando repositório oficial do Docker..."

    sudo install -m 0755 -d /etc/apt/keyrings

    if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
    fi

    ARCH=$(dpkg --print-architecture)
    CODENAME=$(lsb_release -cs)

    echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${CODENAME} stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    log_info "Instalando Docker Engine e Docker Compose Plugin..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin

    TARGET_USER="${SUDO_USER:-$USER}"
    if [ -n "$TARGET_USER" ] && [ "$TARGET_USER" != "root" ]; then
        log_info "Adicionando o usuário '$TARGET_USER' ao grupo 'docker'..."
        sudo usermod -aG docker "$TARGET_USER" || true
        log_warn "Poderá ser necessário fazer logoff/login ou executar 'newgrp docker' para aplicar as permissões do Docker."
    fi

    log_success "Docker e Docker Compose instalados com sucesso!"
}

main() {
    log_info "=== Módulo Docker ==="
    install_docker
}

main "$@"
