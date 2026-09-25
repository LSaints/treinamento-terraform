# Dia 5 — Data sources e provisioners

## Objetivo de aprendizado

- Entender `data` blocks: ler informação de recursos que **já existem** e
  não são gerenciados por esta configuração Terraform.
- Entender `provisioner "local-exec"` e `"remote-exec"` — e por que a
  documentação oficial recomenda tratá-los como **último recurso**.

## Leitura sugerida (gratuita)

- Data Sources: https://developer.hashicorp.com/terraform/language/data-sources
- Provisioners: https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax
- "Provisioners are a last resort": https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax#provisioners-are-a-last-resort

## Exercício prático

1. Fora do Terraform, rode manualmente `docker pull redis:7-alpine` no
   terminal (simulando uma imagem que "já existe" no host, gerenciada por
   outro processo).
2. No `main.tf`, use `data "docker_image" "redis"` para **ler** essa imagem
   já existente (sem gerenciá-la como resource).
3. Crie um `resource "docker_container" "cache"` usando
   `data.docker_image.redis.image_id` como imagem.
4. Adicione um `provisioner "local-exec"` no `docker_container.cache` que
   rode um healthcheck simples após a criação, ex.:
   ```hcl
   provisioner "local-exec" {
     command = "sleep 2 && docker exec ${self.name} redis-cli ping"
   }
   ```
5. Rode `terraform apply` e confirme no output do provisioner que o
   healthcheck retornou `PONG`.
6. Rode `terraform destroy`.

## Entregável

- [ ] `main.tf` com um `data` block funcional (não recria a imagem, apenas
      lê)
- [ ] `provisioner "local-exec"` executando e mostrando `PONG` no `apply`
- [ ] `terraform destroy` limpo

## Perguntas de reflexão (responda em `respostas.md`)

1. Qual a diferença fundamental entre um `resource` e um `data` source em
   termos do que o Terraform faz com aquele objeto no `apply`/`destroy`?
2. Dê um exemplo real (fora do Docker) de quando você usaria um `data`
   source — ex.: referenciar uma VPC ou uma AMI que já existe e é mantida
   por outro time/repositório.
3. Por que a documentação do Terraform recomenda usar provisioners como
   "último recurso"? Que alternativas mais declarativas existem para os
   casos de configuração pós-criação (ex.: cloud-init, imagens
   pré-configuradas, ferramentas de configuration management)?
4. O que acontece com o `local-exec` se o `terraform apply` for rodado numa
   máquina diferente de onde o `destroy` será rodado depois (ex.: CI
   efêmero)? Que tipo de acoplamento isso cria?
