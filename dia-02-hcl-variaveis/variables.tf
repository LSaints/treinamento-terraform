variable "container_name" {
  type        = string
  description = "Nome do container"
  default     = "nginx"
}

variable "image" {
  type        = string
  description = "Nome da imagem do container"
  default     = "nginx:latest"
}

variable "host_port" {
  type        = number
  description = "Porta do host"
  validation {
    condition     = tonumber(var.host_port) >= 1024 && tonumber(var.host_port) <= 65535
    error_message = "A porta deve estar entre 1024 e 65535."
  }
}