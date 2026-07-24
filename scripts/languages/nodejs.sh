#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do Node.js
# Descrição: Instala o Node.js e NVM / NodeSource para gerenciamento de pacotes.
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }

install_nodejs() {
    log_info "Instalando NVM (Node Version Manager)..."
    
    # Instalar nvm
    if [ ! -d "$HOME/.nvm" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    fi

    # Carregar nvm para o shell atual
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    log_info "Instalando Node.js (LTS)..."
    nvm install --lts
    nvm use --lts

    log_success "Node.js instalado via NVM com sucesso! Versão: $(node -v)"
}

main() {
    log_info "=== Módulo Node.js ==="
    install_nodejs
}

main "$@"
