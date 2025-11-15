variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
}

variable "tenant_id" {
  description = "ID del tenant de Azure AD"
  type        = string
}

variable "project_name" {
  description = "Nombre base del proyecto"
  type        = string
  default     = "vehiculos-blindados"
}

variable "location" {
  description = "Region de Azure"
  type        = string
}


variable "sql_admin_user" {
  description = "Usuario administrador del servidor SQL"
  type        = string
  default     = "adminuser"
}

variable "sql_admin_password" {
  description = "Contraseña administrador del servidor SQL"
  type        = string
  sensitive   = true
  default     = "Password1234!"
}
