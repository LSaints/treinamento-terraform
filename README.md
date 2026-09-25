# Treinamento de Terraform — 10 dias, custo zero

Treinamento prático de Terraform para devs backend sem experiência prévia com
cloud. Todo o treinamento roda **100% local**, usando o provider `docker` do
Terraform — sem necessidade de conta AWS/GCP/Azure e sem risco de custo.

## Pré-requisitos

- Docker Engine instalado e rodando (`docker ps` funcionando sem erro)
- Terraform CLI instalado (`terraform version`)
- Editor de texto/IDE de sua preferência

Veja [`setup/INSTALL.md`](setup/INSTALL.md) para o passo a passo de instalação.

## Como usar este treinamento

1. Siga os dias em ordem — cada um assume o conhecimento do anterior.
2. Em cada pasta `dia-XX-*/`, leia o `README.md`: objetivo, leitura sugerida,
   exercício prático e entregável.
3. Crie seu código Terraform **dentro da pasta do dia** (`main.tf`,
   `variables.tf`, etc. conforme pedido).
4. Rode sempre o ciclo: `terraform init` → `terraform validate` →
   `terraform plan` → `terraform apply` → (conferir) → `terraform destroy`.
5. Responda as perguntas de reflexão por escrito em um arquivo
   `respostas.md` dentro da pasta do dia.
6. Só avance para o próximo dia quando o entregável estiver 100% funcional.

## Roteiro

| Dia | Tema | Pasta |
|---|---|---|
| 1 | Fundamentos de IaC e primeiro apply | [`dia-01-fundamentos`](dia-01-fundamentos) |
| 2 | HCL, variáveis e outputs | [`dia-02-hcl-variaveis`](dia-02-hcl-variaveis) |
| 3 | State management | [`dia-03-state`](dia-03-state) |
| 4 | Dependências e lifecycle | [`dia-04-dependencias-lifecycle`](dia-04-dependencias-lifecycle) |
| 5 | Data sources e provisioners | [`dia-05-data-sources-provisioners`](dia-05-data-sources-provisioners) |
| 6 | Módulos | [`dia-06-modulos`](dia-06-modulos) |
| 7 | Workspaces e ambientes | [`dia-07-workspaces`](dia-07-workspaces) |
| 8 | Expressões, `for_each`, `count`, `dynamic` | [`dia-08-for-each-dynamic`](dia-08-for-each-dynamic) |
| 9 | Boas práticas e organização de projeto | [`dia-09-boas-praticas`](dia-09-boas-praticas) |
| 10 | Projeto final (capstone) | [`dia-10-projeto-final`](dia-10-projeto-final) |

## Filosofia do treinamento

- **Custo zero garantido**: nenhum recurso de nuvem real é criado. Tudo é
  container Docker local.
- **Aprender fazendo**: cada dia tem um exercício prático com critério de
  sucesso objetivo (`terraform apply`/`destroy` sem erro).
- **Fixar o "porquê"**: perguntas de reflexão em cada dia conectam a prática
  aos conceitos que importam em ambientes reais de cloud (mesmo que aqui
  simulados localmente).
