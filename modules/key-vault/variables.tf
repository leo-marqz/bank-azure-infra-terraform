
variable "name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "location" {
  description = "The Azure region where the Key Vault should be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group to create the Key Vault in."
  type        = string
}

variable "sku_name" {
  description = "The SKU of the Key Vault (e.g., 'standard')."
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "A map of tags to assign to the Key Vault."
  type        = map(string)
}
