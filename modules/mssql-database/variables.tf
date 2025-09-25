
variable "name" {
  description = "The name of the microservice (e.g., transaction, balance)."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "location_slug" {
  description = "A shortened, unique identifier for the location."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the SQL Server."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the SQL Server."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU for the SQL Database (e.g., 'S0')."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}