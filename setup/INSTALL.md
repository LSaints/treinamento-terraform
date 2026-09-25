# Instalação do ambiente (Linux)

## 1. Docker Engine

Verifique se já está instalado:

```bash
docker version
```

Se não estiver, siga a documentação oficial para sua distribuição:
https://docs.docker.com/engine/install/

Depois de instalar, adicione seu usuário ao grupo `docker` (evita precisar de
`sudo` em todo comando) e reinicie a sessão:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Teste:

```bash
docker run --rm hello-world
```

## 2. Terraform CLI

Baixe o binário oficial (gratuito) em:
https://developer.hashicorp.com/terraform/install

Ou, em distros baseadas em Arch:

```bash
sudo pacman -S terraform
```

Ou via gerenciador de versões `tfenv` (opcional, útil se for usar múltiplas
versões):

```bash
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
export PATH="$HOME/.tfenv/bin:$PATH"
tfenv install latest
tfenv use latest
```

Teste:

```bash
terraform version
```

## 3. Provider Docker do Terraform

Não requer instalação manual — cada pasta de exercício terá um bloco
`required_providers` que baixa o provider automaticamente no
`terraform init`:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}
```

## 4. Checklist final

- [ ] `docker ps` roda sem erro
- [ ] `docker run --rm hello-world` funciona
- [ ] `terraform version` mostra uma versão >= 1.5
- [ ] Nenhuma conta de cloud (AWS/GCP/Azure) é necessária para este treinamento
