# Dia 2 — HCL, variáveis e outputs

## Objetivo de aprendizado

- Separar configuração (`variables.tf`) de código (`main.tf`) e de saída
  (`outputs.tf`) — convenção padrão de projetos Terraform.
- Usar tipos de variável (`string`, `number`, `bool`, `list`, `map`) e
  valores default.
- Usar `validation` blocks para validar input de variáveis.
- Usar `terraform.tfvars` para passar valores sem tocar no código.
- Expor valores úteis via `output`.

## Leitura sugerida (gratuita)

- Input Variables: https://developer.hashicorp.com/terraform/language/values/variables
- Output Values: https://developer.hashicorp.com/terraform/language/values/outputs

## Exercício prático

Parta do `main.tf` do Dia 1 (copie/adapte para esta pasta) e refatore:

1. Crie `variables.tf` com:
   - `variable "container_name"` (string, com default)
   - `variable "image" ` (string, ex.: default `"nginx:latest"`)
   - `variable "host_port"` (number, sem default — obrigatório)
   - Adicione um bloco `validation` em `host_port` garantindo que o valor
     esteja entre 1024 e 65535.
2. No `main.tf`, substitua os valores hardcoded pelas variáveis
   (`var.container_name`, `var.image`, `var.host_port`).
3. Crie `outputs.tf` com pelo menos:
   - `output "container_id"` (id do container criado)
   - `output "container_url"` (ex.: `"http://localhost:${var.host_port}"`)
4. Crie um `terraform.tfvars` definindo `host_port` (obrigatório, sem
   default).
5. Rode o ciclo `init/validate/plan/apply` e confira os outputs com
   `terraform output`.
6. Teste a validação: mude `host_port` para `80` no `.tfvars` e rode
   `terraform plan` — confirme que o erro de validação aparece antes de
   qualquer chamada à API do Docker.

## Entregável

- [X] `variables.tf`, `outputs.tf`, `main.tf`, `terraform.tfvars` nesta pasta
- [X] `host_port` tem `validation` funcional (testada com valor inválido)
- [X] `terraform apply` funciona e `terraform output` mostra `container_url`
      correto
- [X] `terraform destroy` limpo

## Perguntas de reflexão (responda em `respostas.md`)

1. Por que separar variáveis/outputs em arquivos próprios em vez de tudo em
   um único `main.tf`? Que problema isso evita em projetos maiores/times?
   > separar da mais modularidade ao projeto em sí, sem falar que ajuda o time saber exatamente o que procurar e aonde procura, evita que times maiores precisem criar um main.tf de muitas linhas e separe suas responsabilidades além de melhorar a documentação do projeto
2. Qual a diferença entre dar um `default` para uma variável e deixá-la sem
   default? Quando você escolheria cada abordagem em um projeto real?
3. Por que validar input o mais cedo possível (na variável, antes do
   `apply`) é melhor do que deixar a API do provider rejeitar depois?
4. Se `host_port` fosse uma senha de banco de dados em vez de uma porta,
   que problema teria em colocá-la direto no `terraform.tfvars` versionado
   no git? (você vai resolver isso formalmente no Dia 9)
