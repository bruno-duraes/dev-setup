# Instruções do Agente para o projeto dev-setup

Siga estas diretrizes ao realizar alterações neste repositório:

1. **Documentação Obrigatória:** Sempre que um novo recurso, ferramenta ou aplicativo for adicionado ao script de instalação (ou modificado significativamente), você DEVE atualizar o arquivo `README.md`.
2. **Visibilidade:** Garanta que todas as ferramentas e recursos instalados pelo script estejam explicitamente listados na seção "🛠️ Ferramentas Instaladas" do `README.md`.
3. **Consistência:** Mantenha a documentação sincronizada com o código. O `README.md` deve servir como a fonte da verdade para o usuário sobre o que será instalado em seu ambiente.
4. **Verificação:** Antes de concluir qualquer tarefa de adição de funcionalidade, verifique se a atualização do `README.md` foi realizada.
5. **Idempotência Obrigatória:** Todos os scripts de instalação de aplicativos devem implementar verificações de idempotência (ex: `if command -v ...; then ...; return 0; fi`) para evitar re-instalações desnecessárias caso o script seja executado múltiplas vezes.
