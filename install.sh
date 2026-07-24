#!/usr/bin/env bash

# ==============================================================================
# Script Principal de Instalação e Orquestração
# Projeto: dev-setup
# Licença: MIT
# ==============================================================================

set -euo pipefail

# Obter o diretório absoluto onde este script está localizado
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Auto-provisionamento: Se não estivermos em uma pasta git, clona o repositório
if [ ! -d "$SCRIPT_DIR/.git" ]; then
    echo "Repositório não detectado. Preparando ambiente para clonagem..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq git curl
    git clone https://github.com/seu-usuario/dev-setup.git /tmp/dev-setup
    cd /tmp/dev-setup
    exec ./install.sh
fi

# Cores para formatação de logs no terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m' # No Color

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }
log_error()   { echo -e "${RED}[ERRO]${NC} $1"; }

# Handler para captura e tratamento de erros
error_handler() {
    local exit_code=$?
    local line_number=$1
    log_error "Ocorreu um erro na linha ${line_number} (Código de saída: ${exit_code}). Abortando instalação."
    exit "${exit_code}"
}

trap 'error_handler ${LINENO}' ERR

# Validação do sistema operacional (Ubuntu)
check_os() {
    if [ ! -f /etc/os-release ]; then
        log_error "Arquivo /etc/os-release não encontrado. Este script é voltado para sistemas Ubuntu Linux."
        exit 1
    fi

    # Importar variáveis do os-release
    . /etc/os-release

    if [ "${ID:-}" != "ubuntu" ] && [[ ! "${ID_LIKE:-}" =~ "ubuntu" ]]; then
        log_warn "O sistema detectado é '$NAME', mas este script foi otimizado para Ubuntu."
        read -rp "Deseja continuar mesmo assim? (s/N): " choice
        case "$choice" in
            [sS][eE][sS]|[sS]) log_info "Continuando instalação..." ;;
            *) log_info "Instalação cancelada pelo usuário."; exit 0 ;;
        esac
    fi
}

# Validação de permissões de sudo
check_sudo() {
    if ! command -v sudo &> /dev/null; then
        log_error "O comando 'sudo' não está disponível neste sistema."
        exit 1
    fi

    log_info "Verificando permissões de 'sudo'..."
    if ! sudo -v; then
        log_error "Falha na autenticação sudo. Instalação abortada."
        exit 1
    fi
}

# Atualização inicial do sistema
update_system() {
    log_info "Garantindo dependências básicas e atualizando sistema..."
    export DEBIAN_FRONTEND=noninteractive
    
    # Idempotência: Instala dependências básicas apenas se não existirem
    sudo apt-get update -qq
    sudo apt-get install -y -qq git curl software-properties-common
    
    sudo apt-get upgrade -y -qq
    log_success "Sistema atualizado com sucesso."
}

# Função auxiliar para executar subs-scripts de forma segura
run_subscript() {
    local script_path="$1"
    
    if [ -f "$script_path" ]; then
        log_info "Executando o módulo: ${script_path#"$SCRIPT_DIR/"}..."
        chmod +x "$script_path"
        bash "$script_path"
        log_success "Módulo ${script_path#"$SCRIPT_DIR/"} concluído com sucesso."
    else
        log_error "Script não encontrado: $script_path"
        exit 1
    fi
}

main() {
    echo -e "${BOLD}${BLUE}"
    echo "================================================="
    echo "    dev-setup - Configuração de Ambiente"
    echo "================================================="
    echo -e "${NC}"

    check_os
    check_sudo
    update_system

    log_info "Iniciando execução dos módulos de automação..."

    # Execução sequencial dos módulos
    run_subscript "$SCRIPT_DIR/scripts/tools.sh"
    
    log_info "Executando módulos de aplicativos..."
    for app_script in "$SCRIPT_DIR"/scripts/apps/*.sh; do
        run_subscript "$app_script"
    done

    run_subscript "$SCRIPT_DIR/scripts/languages/java.sh"
    run_subscript "$SCRIPT_DIR/scripts/languages/nodejs.sh"

    echo -e "\n${BOLD}${GREEN}"
    echo "================================================="
    echo "  🎉 Ambientes e Ferramentas instalados com sucesso!"
    echo "================================================="
    echo -e "${NC}"
    log_warn "Nota: Se o Docker foi instalado, pode ser necessário reiniciar a sessão/logoff para aplicar o grupo 'docker'."
}

main "$@"
