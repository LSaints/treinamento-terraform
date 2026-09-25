# Dia 8 — Expressões, `for_each`, `count`, `dynamic`

## Objetivo de aprendizado

- Usar `count` para criar N recursos idênticos a partir de um número.
- Usar `for_each` para criar recursos a partir de uma `map`/`set`, com
  chaves estáveis (melhor que `count` na maioria dos casos reais).
- Usar `dynamic` blocks para gerar blocos aninhados repetidos
  dinamicamente.
- Usar expressões (`for`, condicionais `? :`) dentro de variáveis/locals.

## Leitura sugerida (gratuita)

- `count`: https://developer.hashicorp.com/terraform/language/meta-arguments/count
- `for_each`: https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
- `dynamic` blocks: https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
- `for` expressions: https://developer.hashicorp.com/terraform/language/expressions/for

## Exercício prático

1. Crie uma `variable "apps"` do tipo map de objetos, por exemplo:
   ```hcl
   variable "apps" {
     type = map(object({
       image     = string
       host_port = number
     }))
     default = {
       web   = { image = "nginx:latest", host_port = 8101 }
       api   = { image = "nginx:latest", host_port = 8102 }
       admin = { image = "nginx:latest", host_port = 8103 }
     }
   }
   ```
2. Use `for_each = var.apps` em `resource "docker_container" "app"` para
   criar um container por entrada do map, referenciando `each.key` (nome)
   e `each.value.image`/`each.value.host_port`.
3. Adicione um `dynamic "ports"` block (o provider Docker aceita múltiplos
   blocos `ports`) — mesmo que seja só uma porta por app aqui, escreva-o
   como `dynamic` para praticar a sintaxe:
   ```hcl
   dynamic "ports" {
     for_each = [each.value.host_port]
     content {
       internal = 80
       external = ports.value
     }
   }
   ```
4. Crie um `output "app_urls"` que use uma `for` expression para gerar um
   map `{ nome => url }` a partir de `var.apps`.
5. Rode `apply` e confirme os 3 containers rodando em portas diferentes.
6. Adicione uma quarta entrada ao map, rode `terraform plan` de novo e
   observe que **apenas** o novo recurso é adicionado (os outros não são
   recriados) — essa é a vantagem do `for_each` com chave estável sobre
   `count`.
7. `terraform destroy` ao final.

## Entregável

- [ ] `main.tf`/`variables.tf`/`outputs.tf` usando `for_each` a partir de um
      map de objetos
- [ ] Pelo menos um `dynamic` block funcional
- [ ] `output "app_urls"` construído com `for` expression
- [ ] Evidência (em `respostas.md`) de que adicionar uma 4ª entrada no
      `plan` não recria as 3 existentes
- [ ] `terraform destroy` limpo

## Perguntas de reflexão (responda em `respostas.md`)

1. Por que `for_each` com uma `map` é geralmente preferível a `count` com
   uma `list` quando os itens podem ser adicionados/removidos do meio da
   coleção? (Pense em como cada um identifica os recursos no state —
   índice numérico vs. chave.)
2. O que aconteceria no `plan` se você usasse `count = length(var.apps)`
   em vez de `for_each`, e removesse o item do meio da lista? Por que isso
   é um problema em produção?
3. Onde mais no seu dia a dia de backend você já viu o padrão "gerar N
   coisas a partir de uma coleção" (ex.: rotas de uma API, migrations,
   workers)? Como essa analogia ajuda a entender `for_each`?
