#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do DBeaver Community
# Descrição: Instala o DBeaver CE via repositório APT oficial.
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }

export DEBIAN_FRONTEND=noninteractive

install_dbeaver() {
    if command -v dbeaver-ce &> /dev/null || command -v dbeaver &> /dev/null; then
        log_warn "DBeaver já está instalado no sistema. Pulando instalação."
        return 0
    fi

    log_info "Configurando repositório APT do DBeaver..."

    sudo install -m 0755 -d /etc/apt/keyrings

    if [ ! -f /etc/apt/keyrings/dbeaver.gpg ]; then
        curl -fsSL https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/dbeaver.gpg
        sudo chmod a+r /etc/apt/keyrings/dbeaver.gpg
    fi

    echo "deb [signed-by=/etc/apt/keyrings/dbeaver.gpg] https://dbeaver.io/debs/dbeaver-ce /" | \
        sudo tee /etc/apt/sources.list.d/dbeaver.list > /dev/null

    log_info "Instalando DBeaver Community Edition..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq dbeaver-ce

    log_success "DBeaver Community instalado com sucesso!"
}

main() {
    log_info "=== Módulo DBeaver ==="
    install_dbeaver
}

main "$@"
