#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do GitHub CLI (gh)
# Descrição: Adiciona o repositório oficial do GitHub CLI e instala o pacote.
# ==============================================================================

set -euo pipefail

# Cores para formatação de logs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }
log_error()   { echo -e "${RED}[ERRO]${NC} $1"; }

# Garante a execução não interativa do APT
export DEBIAN_FRONTEND=noninteractive

install_gh() {
    if command -v gh &> /dev/null; then
        log_warn "GitHub CLI (gh) já está instalado no sistema. Pulando instalação."
        return 0
    fi

    log_info "Adicionando repositório oficial do GitHub CLI..."

    # Criar diretório para chaves GPG caso não exista
    sudo mkdir -p -m 755 /etc/apt/keyrings

    # Adicionar a chave GPG oficial do GitHub
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/etc/apt/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg

    # Adicionar o repositório GitHub CLI às fontes do APT
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

    log_info "Instalando GitHub CLI..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq gh

    log_success "GitHub CLI (gh) instalado com sucesso!"
}

main() {
    log_info "=== Iniciando instalação do GitHub CLI ==="
    install_gh
    log_success "=== Módulo do GitHub CLI concluído! ==="
}

main "$@"
