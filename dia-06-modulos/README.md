# Dia 6 — Módulos

## Objetivo de aprendizado

- Entender o que é um módulo Terraform (qualquer pasta com arquivos `.tf` é
  um módulo — o `main.tf` raiz que você roda é o "root module").
- Extrair um padrão repetido em um módulo reutilizável com inputs/outputs
  próprios.
- Instanciar o mesmo módulo múltiplas vezes com parâmetros diferentes.

## Leitura sugerida (gratuita)

- Modules: https://developer.hashicorp.com/terraform/language/modules
- Module Blocks: https://developer.hashicorp.com/terraform/language/modules/syntax

## Exercício prático

1. Crie a subpasta `modules/container_app/` com:
   - `variables.tf`: `name`, `image`, `host_port`, `container_port`
     (com default 80), `network_name` (opcional).
   - `main.tf`: um `resource "docker_image"` + `resource "docker_container"`
     usando essas variáveis.
   - `outputs.tf`: `container_id`, `url` (ex.:
     `"http://localhost:${var.host_port}"`).
2. No `main.tf` da raiz desta pasta do dia, instancie o módulo **duas
   vezes** com nomes/portas diferentes:
   ```hcl
   module "web_a" {
     source     = "./modules/container_app"
     name       = "web-a"
     image      = "nginx:latest"
     host_port  = 8081
   }

   module "web_b" {
     source     = "./modules/container_app"
     name       = "web-b"
     image      = "nginx:latest"
     host_port  = 8082
   }
   ```
3. Exponha `module.web_a.url` e `module.web_b.url` como outputs do root.
4. Rode `init/plan/apply` e confirme que ambos containers respondem em
   suas portas.
5. Rode `terraform destroy`.

## Entregável

- [ ] Pasta `modules/container_app/` com `variables.tf`, `main.tf`,
      `outputs.tf`
- [ ] Root `main.tf` instanciando o módulo 2x com parâmetros diferentes
- [ ] `terraform output` mostrando as 2 URLs
- [ ] `terraform destroy` limpo

## Perguntas de reflexão (responda em `respostas.md`)

1. Qual problema um módulo resolve que copiar e colar o mesmo bloco de
   recurso duas vezes não resolve (pense em manutenção futura)?
2. Por que os inputs de um módulo (`variables.tf` dentro dele) formam uma
   espécie de "contrato" ou API do módulo? O que acontece com quem usa o
   módulo se você remover uma variável sem aviso?
3. Se você fosse publicar este módulo para outros times usarem, que
   informação você documentaria no topo do `main.tf` do módulo (mesmo sem
   usar uma ferramenta de docs automática)?
4. Existe uma diferença entre "reutilizar código" (o que módulos fazem) e
   "reutilizar estado" (cada instância do módulo tem seu próprio estado
   dentro do state geral)? Onde no `terraform state list` você veria essa
   diferença?
