# Dia 9 — Boas práticas e organização de projeto

## Objetivo de aprendizado

- Usar `terraform fmt` e `terraform validate` como parte do fluxo normal.
- Estrutura padrão de projeto Terraform (nomes de arquivo convencionais).
- Nunca commitar `.tfstate`, `.terraform/`, ou `.tfvars` com segredos.
- Marcar variáveis sensíveis com `sensitive = true`.
- Escrever um `README.md` de projeto que documente inputs/outputs.

## Leitura sugerida (gratuita)

- Style Guide: https://developer.hashicorp.com/terraform/language/style
- Sensitive values: https://developer.hashicorp.com/terraform/language/values/variables#suppressing-values-in-cli-output
- `.gitignore` recomendado pela HashiCorp:
  https://github.com/github/gitignore/blob/main/Terraform.gitignore

## Exercício prático

1. Pegue o projeto do Dia 8 (copie para cá) e:
   - Rode `terraform fmt` e observe o que ele reformata.
   - Rode `terraform validate` e corrija qualquer aviso.
2. Adicione uma variável sensível de exemplo, ex.:
   ```hcl
   variable "admin_password" {
     type      = string
     sensitive = true
     default   = "changeme-local-only"
   }
   ```
   Use-a em uma env var de um dos containers e rode `terraform apply` —
   confirme que o valor **não aparece** no output do plan/apply.
3. Crie um `.gitignore` nesta pasta cobrindo, no mínimo:
   ```
   .terraform/
   *.tfstate
   *.tfstate.*
   *.tfvars
   !example.tfvars
   crash.log
   ```
4. Renomeie (ou crie) um `terraform.tfvars.example` (sem segredos reais,
   só a estrutura) para documentar quais variáveis um novo dev precisa
   preencher — esse arquivo **pode** ser commitado.
5. Escreva um `README.md` de projeto (nesta pasta) documentando: o que o
   projeto cria, como rodar, quais variáveis existem.
6. Rode `terraform destroy` ao final.

## Entregável

- [ ] `terraform fmt` e `terraform validate` rodados sem pendências
- [ ] Ao menos uma variável `sensitive = true`, confirmada como oculta no
      output do `apply`
- [ ] `.gitignore` cobrindo state, `.terraform/` e `.tfvars` reais
- [ ] `terraform.tfvars.example` documentando as variáveis sem segredos
- [ ] `README.md` do projeto com instruções de uso
- [ ] `terraform destroy` limpo

## Perguntas de reflexão (responda em `respostas.md`)

1. Por que o `.tfstate` não deve ir para o git mesmo em um projeto pessoal
   pequeno? Cite pelo menos dois motivos (segredo exposto + conflito de
   merge).
2. O que `sensitive = true` realmente esconde (e o que **não** esconde —
   ex.: ainda aparece em texto claro dentro do `.tfstate`)? Isso muda sua
   resposta sobre por que o state não pode ser commitado?
3. Por que separar `terraform.tfvars` (real, com valores do seu ambiente,
   git-ignored) de `terraform.tfvars.example` (template, commitado) ajuda
   um novo membro do time a rodar o projeto sem vazar segredos?
4. O que você mudaria neste projeto se ele fosse ser usado por mais 3
   pessoas do seu time a partir de amanhã?
