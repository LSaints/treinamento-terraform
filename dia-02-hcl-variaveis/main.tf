terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {

}


resource "docker_image" "nginx" {
  name = var.image
}

resource "docker_container" "container" {
  name  = "container"
  image = var.container_name

  ports {
    internal = 80
    external = var.host_port
  }
}