# Dia 3 — State management

## Objetivo de aprendizado

- Entender o que é o `terraform.tfstate`: o "mapa" que o Terraform mantém
  entre a sua configuração declarada e os recursos reais existentes.
- Entender por que o state existe (sem ele, o Terraform não saberia o que já
  foi criado, nem conseguiria calcular diffs).
- Conhecer os comandos de inspeção de state.
- Entender (conceitualmente, mesmo rodando local) remote state e state
  locking — fundamentais em qualquer time real.

## Leitura sugerida (gratuita)

- Terraform State: https://developer.hashicorp.com/terraform/language/state
- Remote State: https://developer.hashicorp.com/terraform/language/state/remote
- State Locking: https://developer.hashicorp.com/terraform/language/state/locking

## Exercício prático

Use o projeto do Dia 2 (copie para esta pasta) e explore o state:

1. Rode `terraform apply` normalmente.
2. Rode `terraform state list` — veja os recursos rastreados.
3. Rode `terraform state show docker_container.<nome>` — veja todos os
   atributos que o Terraform guarda sobre o recurso real.
4. Abra o arquivo `terraform.tfstate` num editor de texto (NÃO edite à mão)
   e observe a estrutura JSON.
5. Simule um "drift": pare o container manualmente com
   `docker stop <nome_do_container>` (fora do Terraform). Rode
   `terraform plan` — observe como o Terraform detecta a divergência entre
   state e realidade.
6. Rode `terraform apply` de novo para corrigir o drift.
7. Rode `terraform destroy` ao final.

## Entregável

- [ ] Print ou cópia (em `respostas.md`) da saída de `terraform state list`
- [ ] Print ou cópia da saída de `terraform state show` para o container
- [ ] Descrição em `respostas.md` do que aconteceu no `plan` depois do
      drift simulado (o que o Terraform propôs fazer?)
- [ ] `terraform destroy` limpo ao final

## Perguntas de reflexão (responda em `respostas.md`)

1. O `.tfstate` contém informações sensíveis (ex.: IDs, IPs, às vezes até
   senhas em texto claro se forem atributos de recursos). Por que ele nunca
   deve ser commitado no git?
2. Neste treinamento o state é local (um arquivo na sua máquina). Se dois
   colegas de time rodassem `terraform apply` ao mesmo tempo usando esse
   mesmo state local compartilhado por uma pasta de rede, o que poderia dar
   errado?
3. O que é "remote state" (ex.: state guardado num bucket S3 ou storage
   account, em vez de local)? Que problema do item anterior ele resolve?
4. O que é "state locking" e por que ele é o complemento necessário do
   remote state (o que aconteceria sem lock, mesmo com state remoto)?
5. O que você observou no `plan` depois de parar o container manualmente
   mostra o quê sobre a filosofia do Terraform (state como fonte de verdade
   vs. realidade observada)?
