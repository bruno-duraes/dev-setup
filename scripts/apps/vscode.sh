#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do Visual Studio Code
# Descrição: Instala o VS Code via repositório APT oficial da Microsoft.
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

install_vscode() {
    if command -v code &> /dev/null; then
        log_warn "VS Code já está instalado no sistema. Pulando instalação."
        return 0
    fi

    log_info "Configurando repositório APT do VS Code (Microsoft)..."

    sudo install -m 0755 -d /etc/apt/keyrings

    if [ ! -f /etc/apt/keyrings/microsoft.gpg ]; then
        curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
        sudo chmod a+r /etc/apt/keyrings/microsoft.gpg
    fi

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
        sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

    log_info "Instalando Visual Studio Code..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq code

    log_success "Visual Studio Code instalado com sucesso!"
}

main() {
    log_info "=== Módulo VS Code ==="
    install_vscode
}

main "$@"
