# Dia 7 — Workspaces e ambientes

## Objetivo de aprendizado

- Entender `terraform workspace` como mecanismo para ter múltiplos states
  isolados a partir da **mesma configuração**.
- Entender quando workspaces são adequados (variações pequenas, mesmo
  código) vs. quando é melhor ter diretórios/repos separados por ambiente
  (variações grandes, ex.: dev vs prod com módulos diferentes).
- Usar `.tfvars` por ambiente combinados com workspaces.

## Leitura sugerida (gratuita)

- Workspaces: https://developer.hashicorp.com/terraform/language/state/workspaces
- (Opinião oficial da HashiCorp sobre limitações de workspaces para
  ambientes de produção — vale ler para entender o trade-off, não é bala de
  prata)

## Exercício prático

1. Reaproveite o módulo `container_app` do Dia 6 (copie a pasta `modules/`
   para cá, ou referencie via `source = "../dia-06-modulos/modules/container_app"`).
2. No root `main.tf` desta pasta, instancie o módulo uma vez, mas com
   `host_port` vindo de uma variável `host_port`, sem default fixo.
3. Crie dois arquivos de variáveis: `dev.tfvars` (ex.: `host_port = 8090`)
   e `staging.tfvars` (ex.: `host_port = 8091`).
4. Crie os workspaces:
   ```bash
   terraform workspace new dev
   terraform workspace new staging
   ```
5. Aplique em cada workspace com seu respectivo `.tfvars`:
   ```bash
   terraform workspace select dev
   terraform apply -var-file=dev.tfvars

   terraform workspace select staging
   terraform apply -var-file=staging.tfvars
   ```
6. Rode `docker ps` e confirme que **dois containers diferentes** existem
   ao mesmo tempo, um por workspace.
7. Use `terraform.workspace` dentro do `main.tf` para nomear o container
   incluindo o nome do workspace (ex.: `name = "app-${terraform.workspace}"`).
8. Destrua os dois: selecione cada workspace e rode `terraform destroy
   -var-file=<respectivo>.tfvars`.

## Entregável

- [ ] `main.tf`, `variables.tf`, `dev.tfvars`, `staging.tfvars` nesta pasta
- [ ] Dois workspaces (`dev`, `staging`) criados e aplicados
      simultaneamente, com containers e portas diferentes
- [ ] `docker ps` mostrando os 2 containers rodando ao mesmo tempo (capture
      em `respostas.md`)
- [ ] Ambos destruídos ao final

## Perguntas de reflexão (responda em `respostas.md`)

1. O que exatamente muda por trás dos panos quando você troca de workspace
   (`terraform workspace select`)? (Dica: pense em onde o Terraform guarda
   o state de cada workspace.)
2. Por que workspaces são uma boa ideia para variações pequenas do mesmo
   código (ex.: dev/staging de uma mesma app), mas a documentação oficial
   desaconselha usá-los para isolar ambientes muito diferentes, como
   dev vs. produção com controles de acesso distintos?
3. Qual a alternativa a workspaces para isolar ambientes fortemente (ex.:
   diretórios separados por ambiente, cada um com seu próprio backend de
   state)? Que trade-off isso implica (duplicação de código vs. isolamento
   mais forte)?
4. Que risco existe se alguém esquecer de trocar de workspace antes de
   rodar `terraform apply` num projeto real com cloud de verdade?
