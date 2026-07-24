#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do Google Chrome
# Descrição: Instala o Google Chrome via pacote oficial .deb.
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

install_chrome() {
    if command -v google-chrome &> /dev/null; then
        log_warn "Google Chrome já está instalado. Pulando instalação."
        return 0
    fi

    log_info "Baixando e instalando Google Chrome..."
    
    # Download do pacote .deb oficial
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
    
    # Instalação (com correção de dependências caso necessário)
    sudo apt-get install -y -qq /tmp/google-chrome-stable_current_amd64.deb
    
    rm /tmp/google-chrome-stable_current_amd64.deb

    log_success "Google Chrome instalado com sucesso!"
}

main() {
    log_info "=== Módulo Google Chrome ==="
    install_chrome
}

main "$@"
