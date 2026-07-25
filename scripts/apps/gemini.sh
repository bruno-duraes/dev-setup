#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do Gemini CLI
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }

install_gemini_cli() {
    if command -v gemini &> /dev/null; then
        log_warn "Gemini CLI já está instalado no sistema. Pulando instalação."
        return 0
    fi

    log_info "Instalando Gemini CLI (via npm)..."
    
    # Assegura que o NVM está carregado antes de instalar
    (
        set +u
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        npm install -g @google/gemini-cli
    )

    log_success "Gemini CLI instalado com sucesso."
}

main() {
    log_info "=== Módulo Gemini CLI ==="
    install_gemini_cli
}

main "$@"
