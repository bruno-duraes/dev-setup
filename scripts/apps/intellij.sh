#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do IntelliJ IDEA Community
# Descrição: Instala o IntelliJ IDEA Community Edition via Snap.
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }

install_intellij() {
    if command -v intellij-idea-community &> /dev/null || snap list intellij-idea-community &> /dev/null; then
        log_warn "IntelliJ IDEA Community já está instalado no sistema. Pulando instalação."
        return 0
    fi

    log_info "Instalando IntelliJ IDEA Community via Snap..."
    sudo snap install intellij-idea-community --classic

    log_success "IntelliJ IDEA Community instalado com sucesso!"
}

main() {
    log_info "=== Módulo IntelliJ IDEA Community ==="
    install_intellij
}

main "$@"
