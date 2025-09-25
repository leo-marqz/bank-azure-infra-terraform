
variable "azure_location" {
  type        = string
  default     = "westus2"
  description = "West US 2"
}

variable "azure_location_slug" {
  type    = string
  default = "west-us-2"
}

variable "app_service_plan_sku" {
  type    = string
  default = "B1"
}

variable "mssql_server_sku" {
  type    = string
  default = "Basic"
}

variable "bank_microservices_tags" {
  type = map(string)
  default = {
    "Environment" = "Development"
    "Owner"       = "leomarqz"
    "Email"       = "leomarqz2020@gmail.com"
    "Description" = "Microservices with C# and Asp.Net in .Net 8"
    "IaC": "Terraform"
  }
}

# Credenciales de prueba temporales para base de datos

variable "tmp_username" {
  type    = string
  default = ""
}

variable "tmp_password" {
  type    = string
  default = ""
}

