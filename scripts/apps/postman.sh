#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do Postman
# Descrição: Instala o Postman via Snap.
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }

install_postman() {
    if command -v postman &> /dev/null || snap list postman &> /dev/null; then
        log_warn "Postman já está instalado. Pulando instalação."
        return 0
    fi

    log_info "Instalando Postman via Snap..."
    sudo snap install postman

    log_success "Postman instalado com sucesso!"
}

main() {
    log_info "=== Módulo Postman ==="
    install_postman
}

main "$@"
