output "container_id" {
  description = "ID do container criado"
  value       = docker_container.container.id
}

output "container_url" {
  description = "URL do container criado"
  value       = "http://localhost:${var.host_port}"
}