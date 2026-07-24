# Ambiente de Desenvolvimento (`dev-setup`)

Scripts modulares em Shell Script para a configuração rápida, automatizada e padronizada de um ambiente de desenvolvimento completo em uma instalação limpa do Ubuntu.

O `dev-setup` automatiza a instalação de ferramentas essenciais, linguagens de programação (gerenciadas por NVM e SDKMAN) e aplicativos de produtividade.

## 🛠️ Ferramentas Instaladas

- **Sistema:** Git, cURL, Build-Essential, htop, tree, jq e mais.
- **Containers:** Docker Engine e Docker Compose.
- **Linguagens:** Node.js (via NVM) e Java (via SDKMAN).
- **Aplicativos:** VS Code, IntelliJ IDEA Community, DBeaver, Postman e Google Chrome.

## 🚀 Utilização

Para configurar todo o seu ambiente em uma máquina nova (recém-formatada) com um único comando, basta executar:

```bash
bash <(curl -s https://raw.githubusercontent.com/bruno-duraes/dev-setup/main/install.sh)
```
