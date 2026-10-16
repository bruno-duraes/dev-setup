#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do Codex CLI
# Descrição: Instala o Codex CLI via npm após carregar o Node.js do NVM.
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }

install_codex_cli() {
    (
        set +u
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

        if command -v codex &> /dev/null; then
            log_warn "Codex CLI já está instalado no sistema. Pulando instalação."
            exit 0
        fi

        log_info "Instalando Codex CLI (via npm)..."
        npm install -g @openai/codex@latest
        log_success "Codex CLI instalado com sucesso!"
    )
}

main() {
    log_info "=== Módulo Codex CLI ==="
    install_codex_cli
}

main "$@"
