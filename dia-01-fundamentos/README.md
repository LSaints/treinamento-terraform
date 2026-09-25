# Dia 1 — Fundamentos de IaC e primeiro apply

## Objetivo de aprendizado

- Entender o que é Infrastructure as Code (IaC) e por que ela existe.
- Entender o papel do Terraform: core (motor de execução) + providers
  (plugins que falam com APIs específicas, ex.: AWS, Docker, Kubernetes).
- Entender o ciclo básico: `init` → `plan` → `apply` → `destroy`.
- Escrever seu primeiro arquivo HCL (`.tf`).

## Por que isso importa (para um dev backend)

Você já escreve código que declara *o que* o sistema deve fazer (ex.: uma
função que recebe input e retorna output) em vez de instruções imperativas
passo a passo. Terraform aplica essa mesma ideia de **declaratividade** à
infraestrutura: você descreve o estado desejado (“quero um container rodando
nginx na porta 8080”) e o Terraform calcula o que precisa criar/mudar/remover
para chegar lá.

## Leitura sugerida (gratuita)

- Terraform docs — "What is Terraform?":
  https://developer.hashicorp.com/terraform/intro
- Terraform docs — Core Workflow:
  https://developer.hashicorp.com/terraform/intro/core-workflow

## Exercício prático

1. Crie nesta pasta um arquivo `main.tf` com:
   - Bloco `terraform { required_providers { ... } }` declarando o provider
     `kreuzwerker/docker`.
   - Bloco `provider "docker" {}`.
   - Um `resource "docker_image"` para a imagem `nginx:latest`.
   - Um `resource "docker_container"` que usa essa imagem, expõe a porta
     `80` do container na porta `8080` do host, e dá um nome ao container.
2. Rode o ciclo completo:
   ```bash
   terraform init
   terraform validate
   terraform plan
   terraform apply
   ```
3. Confirme no navegador ou com `curl localhost:8080` que o nginx responde.
4. Rode `terraform destroy` e confirme com `docker ps -a` que o container
   sumiu.

## Entregável

- [ ] `main.tf` criado nesta pasta, versionável (sem segredos hardcoded)
- [ ] `terraform init` roda sem erro
- [ ] `terraform validate` roda sem erro
- [ ] `terraform apply` cria o container e o nginx responde em `localhost:8080`
- [ ] `terraform destroy` remove tudo (confirmado via `docker ps -a`)

## Perguntas de reflexão (responda em `respostas.md`)

1. Qual a diferença entre uma ferramenta declarativa (Terraform) e uma
   imperativa (um script bash que roda `docker run` passo a passo)? Que
   problema a abordagem declarativa resolve quando você roda o mesmo código
   várias vezes (idempotência)?
   > uma ferramenta declarativa define o estado que aquela solução deve alcançar e a ferramenta define como alcançar esse estado, já a imperativa é definida como uma sequencia de passos deterministicos a ser seguida, a forma declarativa resolve o seguinte problema: como eu preciso chegar ao resultado daquele estado então preciso me antentar ao estado final não na sequencia deterministica de passos antes daquele resultado, já que o estado é definido se o estado estiver alcaçado não precisa repetir
2. O que o `terraform plan` te mostrou antes do `apply`? Por que esse passo
   é importante em um time, mesmo fora do contexto Docker/local?
   > mostra o que o terraform irá modificar ou aplicar de novo na infrastrutura, é importante pois o time pode verificar essas mundanças e confirmar se realmente é o de fato que vai mudar ou ser aplicado 
3. O que aconteceria se você rodasse `terraform apply` duas vezes seguidas
   sem mudar nada no `main.tf`? Por quê?
   > Nada. Pois como o terraform é declarativo ele precisa alcaçar aquele estado desejado, já que o estado desejado já foi alcaçado pelo o primeiro `apply` ele não precisa alcaçar novamente
