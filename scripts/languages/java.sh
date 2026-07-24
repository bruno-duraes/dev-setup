#!/usr/bin/env bash

# ==============================================================================
# Módulo: Instalação do Java
# Descrição: Instala o OpenJDK / SDKMAN para gerenciamento do ambiente Java.
# ==============================================================================

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }

install_java() {
    log_info "Instalando SDKMAN (para gerenciamento de versões Java)..."
    
    # Instala o SDKMAN caso não exista
    if [ ! -d "$HOME/.sdkman" ]; then
        curl -s "https://get.sdkman.io" | bash
    fi

    # Carrega e usa o SDKMAN em um subshell sem nounset
    (
        set +u
        export SDKMAN_DIR="$HOME/.sdkman"
        [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

        log_info "Instalando a versão Java LTS mais recente via SDKMAN..."
        sdk install java 25-tem 
    ) 
    
    log_success "Java instalado com sucesso via SDKMAN."
}

main() {
    log_info "=== Módulo Java ==="
    install_java
}

main "$@"
