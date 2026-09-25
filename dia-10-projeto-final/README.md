# Dia 10 — Projeto final (capstone)

## Objetivo

Integrar tudo que foi praticado nos dias 1-9 em um único projeto coeso: um
mini-stack local, 100% Docker, representando uma arquitetura realista de
backend — API + banco de dados + proxy reverso — totalmente provisionada
via Terraform.

## Requisitos do projeto

Construa uma stack com:

1. **Rede Docker dedicada** (`docker_network`).
2. **Banco de dados** (ex.: `postgres:16-alpine`), com variáveis
   sensíveis (`sensitive = true`) para usuário/senha, dentro da rede.
3. **API** — pode ser uma imagem simples (ex.: uma imagem sua de teste, ou
   `nginx:latest` simulando o papel de "app"), conectada à rede, com
   `depends_on` no banco.
4. **Proxy reverso** (ex.: outro `nginx:latest` na frente da API,
   expondo a única porta pública da stack ao host).
5. **Módulo reutilizável**: pelo menos um dos três componentes acima deve
   vir de um módulo próprio (reaproveite/adapte o `container_app` do
   Dia 6).
6. **`for_each`**: se fizer sentido no seu design (ex.: múltiplas réplicas
   da API), use `for_each` para criar as instâncias.
7. **Variáveis e outputs completos**: `variables.tf` parametrizando nomes/
   portas/imagens, `outputs.tf` expondo a URL pública final da stack.
8. **Organização de projeto** (Dia 9): `.gitignore`,
   `terraform.tfvars.example`, `README.md` de arquitetura nesta pasta.
9. **Workspaces (opcional, bônus)**: suporte a rodar a stack em dois
   workspaces (`dev`/`staging`) com portas diferentes.

## Entregável

- [ ] `terraform init && terraform validate && terraform plan` sem erros
- [ ] `terraform apply` sobe a stack completa (rede + banco + api + proxy)
- [ ] Acesso via `curl localhost:<porta_publica>` passando pelo proxy até a
      API
- [ ] `docker network inspect` confirmando todos os containers na mesma
      rede
- [ ] `terraform destroy` remove tudo sem sobras (`docker ps -a` limpo)
- [ ] `README.md` de arquitetura nesta pasta, com um diagrama simples em
      texto (ASCII ou lista) explicando os componentes e como se conectam
- [ ] `.gitignore` + `terraform.tfvars.example` presentes
- [ ] Nenhum segredo commitável (senha do banco como `sensitive`)

## Perguntas de reflexão finais (responda em `respostas.md`)

1. Olhando para os 10 dias, qual conceito você acha que mais muda a forma
   como você pensa sobre infraestrutura, comparado a como você lidava com
   ambientes antes (manual, scripts, etc.)?
2. Se este projeto fosse migrar de Docker local para AWS/GCP amanhã, o que
   mudaria no código (providers, resources) e o que **não** mudaria
   (estrutura de módulos, variáveis, outputs, boas práticas)?
3. Qual foi o entregável mais difícil dos 10 dias e por quê? O que você
   faria diferente revendo agora?
4. O que você ainda não sabe sobre Terraform que gostaria de aprender em
   seguida (ex.: backends remotos de verdade, Terraform Cloud, testing com
   `terraform test`, providers customizados, OpenTofu)?

## Próximos passos sugeridos (fora deste treinamento, também gratuitos)

- `terraform test`: framework de testes nativo (gratuito, local):
  https://developer.hashicorp.com/terraform/language/tests
- Um provedor de cloud real, dentro do free tier (ex.: AWS free tier por
  12 meses), aplicando os mesmos conceitos a recursos de nuvem de verdade —
  com atenção redobrada a billing alerts para não sair do zero custo.
- OpenTofu (fork open-source do Terraform), para conhecer o ecossistema
  além da HashiCorp: https://opentofu.org/
