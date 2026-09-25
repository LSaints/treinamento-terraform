# Dia 4 — Dependências e lifecycle

## Objetivo de aprendizado

- Entender dependência implícita (quando um recurso referencia atributo de
  outro via interpolação) vs. dependência explícita (`depends_on`).
- Entender como o Terraform constrói um grafo de dependências e por que a
  ordem de criação/destruição importa.
- Conhecer o bloco `lifecycle` (`create_before_destroy`, `prevent_destroy`,
  `ignore_changes`).

## Leitura sugerida (gratuita)

- Resource Dependencies: https://developer.hashicorp.com/terraform/language/resources/behavior#resource-dependencies
- Meta-arguments — `depends_on`: https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on
- Lifecycle: https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle

## Exercício prático

Crie um cenário com 3 recursos que simula uma app + banco na mesma rede:

1. `resource "docker_network" "app_net"` — uma rede Docker dedicada.
2. `resource "docker_container" "db"` — ex.: imagem `postgres:16-alpine`,
   variáveis de ambiente mínimas (`POSTGRES_PASSWORD`), conectado à
   `app_net` (dependência **implícita** via `networks_advanced` referenciando
   `docker_network.app_net.name`).
3. `resource "docker_container" "app"` — ex.: imagem `nginx:latest`,
   conectado à mesma rede. Adicione `depends_on = [docker_container.db]`
   **explicitamente**, mesmo que não haja referência direta de atributo —
   simulando o caso real "minha app precisa que o banco suba primeiro".
4. Adicione um bloco `lifecycle { create_before_destroy = true }` no
   `docker_container.app` e explique (na reflexão) o efeito disso.
5. Rode `terraform apply` e confira com `docker network inspect app_net`
   que os dois containers estão na mesma rede.
6. Rode `terraform destroy` e observe a ordem em que os recursos são
   destruídos no output do terminal.

## Entregável

- [ ] `main.tf` com rede + 2 containers, uma dependência implícita e uma
      explícita (`depends_on`)
- [ ] `docker network inspect` confirmando os containers na mesma rede
- [ ] `terraform apply`/`destroy` limpos
- [ ] Anotação em `respostas.md` da ordem de criação e destruição observada
      no output do Terraform

## Perguntas de reflexão (responda em `respostas.md`)

1. Qual a diferença prática entre a dependência implícita (via
   `docker_network.app_net.name`) e a explícita (`depends_on`)? Por que a
   implícita é preferível sempre que possível?
2. Dê um exemplo (pode ser hipotético, fora do Docker) de uma situação onde
   `depends_on` explícito é realmente necessário porque não há referência de
   atributo entre os recursos.
3. O que `create_before_destroy = true` muda na ordem de operações quando
   você precisa recriar um recurso (ex.: mudar um atributo que força
   replace)? Por que isso é importante para recursos que não podem ter
   downtime (ex.: um load balancer)?
4. O que `prevent_destroy = true` faz, e em que tipo de recurso real
   (pense em produção) você aplicaria essa trava?
